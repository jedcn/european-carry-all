module European

  class CarryAll

    def initialize
      @projects = {}
      @build_systems = {}
      @deploy_systems = {}
      @source_systems = {}
      @post_setup_procs = []
    end

    def setup
      @source_systems.values.each { |system| system.setup }
      @build_systems.values.each { |system| system.setup }
      @deploy_systems.values.each { |system| system.setup }
      default_project = @projects['defaults']
      default_project.setup if default_project
      @projects.delete 'defaults'
      @projects.values.each do |project|
        next if project == default_project
        project.exec default_project.proc if default_project
        project.setup
      end
      @post_setup_procs.each do |proc|
        instance_eval &proc
      end
    end

    def add_project(project)
      @projects[project.name] = project
    end

    def add_build_system(build_system)
      @build_systems[build_system.name] = build_system
    end

    def add_deploy_system(deploy_system)
      @deploy_systems[deploy_system.name] = deploy_system
    end

    def add_source_system(source_system)
      @source_systems[source_system.name] = source_system
    end

    def after_setup(&block)
      @post_setup_procs << block
    end

    # TODO: Ack! This is shadowing the kernel defined 'project' from
    # the DSL portion in load_file. Is there anyway to avoid globally
    # defining 'project'?
    def project(args)
      named = args[:named] || raise(':named is required')
      @projects[named]
    end

    def projects
      @projects.values
    end

    def build_system(args)
      named = args[:named] || raise(':named is required')
      @build_systems[named]
    end

    def build_systems
      @build_systems.values
    end

    def deploy_system(args)
      named = args[:named] || raise(':named is required')
      @deploy_systems[named]
    end

    def deploy_systems
      @deploy_systems.values
    end

    def source_system(args)
      named = args[:named] || raise(':named is required')
      @source_systems[named]
    end

    def source_systems
      @source_systems.values
    end

    def register(item, action, name)
      if item.class == Project
        project = item
        if action == :has_build
          ni = NameInterpreter.new name
          build_system_name = ni.prefix
          build_name = ni.name
          build_system = build_systems.find { |bs| bs.name == build_system_name }
          if build_system.build named: build_name
            raise "#{build_system} already has a build named #{build_name}'"
          end
          url = build_system.url_for_project_named build_name
          build = Build.new build_system: build_system, project: project, name: build_name, url: url
          build_system.add_build build
          build_system.add_project project
          project.add_build_system build_system
          project.add_build build
        elsif action == :is_hosted_on
          source_system = @source_systems[name]
          raise "Unknown SourceSystem '#{name}'" unless source_system
          project.source_system = source_system
          source_system.add_project project
          url = source_system.src_url_for_project_named project.name
          project.src_url = url
        elsif action == :deploys_from
          deploy_system = @deploy_systems[name]
          raise "Unknown DeploySystem '#{name}'" unless deploy_system
          project.deploy_systems << deploy_system
          deploy_system.add_project project
        elsif action == :has_deploy
          ni = NameInterpreter.new name
          deploy_system_name = ni.prefix
          build_name = ni.name
          deploy_system = deploy_systems.find { |ds| ds.name == deploy_system_name }
          if deploy_system.build named: build_name
            raise "#{deploy_system} already has a deploy named '#{build_name}'"
          end
          url = deploy_system.url_for_project_named build_name
          deploy = Build.new build_system: deploy_system, project: project, name: build_name, url: url
          deploy_system.add_build deploy
          project.add_deploy deploy
        end
      end
    end

  end
end


module European

  class CarryAll

    require 'tempfile'
    require 'open-uri'

    def self.load_url(url)
      file = Tempfile.new 'carry_all'
      url_content = open(url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE).read
      file.write url_content
      file.close
      load_file file.path
    end

    def self.load_file(file)
      carry_all = CarryAll.new
      lambda {
        # TODO: Is there any way to define this.. just on an object..
        # and have that DSL file be loaded in the context of that object?
        Kernel.send :define_method, :project do |name, &block|
          carry_all.add_project(European::Project.new({name: name, proc: block, carry_all: carry_all}))
        end

        Kernel.send :define_method, :build do |name|
          carry_all.after_setup do
            ni = NameInterpreter.new name
            build_system_name = ni.prefix
            build_name = ni.name
            build_system = @build_systems[build_system_name]
            if build_system.build named: name
              raise "#{build_system} already has a build named #{name}'"
            end
            url = build_system.url_for_project_named build_name
            build = Build.new build_system: build_system, project: nil, name: build_name, url: url
            build_system.add_build build
          end
        end

        Kernel.send :define_method, :build_system do |name, &block|
          carry_all.add_build_system(European::BuildSystem.new({name: name, proc: block, carry_all: carry_all}))
        end

        Kernel.send :define_method, :deploy_system do |name, &block|
          carry_all.add_deploy_system(European::DeploySystem.new({name: name, proc: block, carry_all: carry_all}))
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
