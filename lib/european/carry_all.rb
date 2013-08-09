module European

  class CarryAll

    attr_reader :projects, :build_systems, :source_systems

    def initialize
      @projects = {}
      @build_systems = {}
      @source_systems = {}
    end

    def setup
      source_systems.values.each { |system| system.setup }
      build_systems.values.each { |system| system.setup }
      default_project = projects['defaults']
      default_project.setup if default_project
      projects.values.each do |project|
        next if project == default_project
        project.exec default_project.proc if default_project
        project.setup
      end
    end

    def add_project(project)
      projects[project.name] = project
    end

    def add_build_system(build_system)
      build_systems[build_system.name] = build_system
    end

    def add_source_system(source_system)
      source_systems[source_system.name] = source_system
    end

    def register(item, action, name)
      if item.class == Project
        project = item
        if action == :builds_in
          build_system = @build_systems[name]
          raise "Unknown BuildSystem '#{name}'" unless build_system
          project.build_system = build_system
          build_system.add_project project
        elsif action == :has_build
          build_system = project.build_system
          if build_system.builds[name]
            raise "#{build_system} already has a build named #{name}'"
          end
          url = build_system.url_for_project_named name
          build = Build.new build_system: build_system, project: project, name: name, url: url
          build_system.add_build build
          project.add_build build
        elsif action == :is_hosted_on
          source_system = @source_systems[name]
          raise "Unknown SourceSystem '#{name}'" unless source_system
          project.source_system = source_system
          source_system.add_project project
          url = source_system.src_url_for_project_named project.name
          project.src_url = url
        end
      end
    end

  end
end


module European

  class CarryAll

    def self.load_file(file)
      carry_all = CarryAll.new
      lambda {
        Kernel.send :define_method, :project do |name, &block|
          carry_all.add_project(European::Project.new({name: name, proc: block, carry_all: carry_all}))
        end

        Kernel.send :define_method, :build_system do |name, &block|
          carry_all.add_build_system(European::BuildSystem.new({name: name, proc: block, carry_all: carry_all}))
        end

        Kernel.send :define_method, :source_system do |name, &block|
          carry_all.add_source_system(European::SourceSystem.new({name: name, proc: block, carry_all: carry_all}))
        end
      }.call
      load file
      carry_all.setup
      carry_all
    end

  end
end
