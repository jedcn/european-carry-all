module European

  class CarryAll

    attr_reader :projects, :build_systems

    def initialize
      @projects = {}
      @build_systems = {}
    end

    def setup
      build_systems.values.each do |build_system|
        build_system.setup
      end
      projects.values.each do |project|
        project.setup
      end
    end

    def add_project(project)
      projects[project.name] = project
    end

    def add_build_system(build_system)
      build_systems[build_system.name] = build_system
    end

    def register(item, action, name)
      if item.class == Project
        project = item
        if action == :builds_in
          build_system = @build_systems[name]
          project.build_system = build_system
          build_system.add_project project
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
          carry_all.add_project(European::Project.new({name: name, block: block, carry_all: carry_all}))
        end

        Kernel.send :define_method, :build_system do |name, &block|
          carry_all.add_build_system(European::BuildSystem.new({name: name, block: block, carry_all: carry_all}))
        end
      }.call
      load file
      carry_all.setup
      carry_all
    end

  end
end
