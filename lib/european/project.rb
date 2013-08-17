module European
  class Project < NamedCarryAllItem

    attr_reader :carry_all

    attr_accessor :build_systems, :source_system, :deploy_systems

    attr_accessor :builds, :deploys, :src_url

    def initialize(args)
      @carry_all = args[:carry_all] || raise(':carry_all is required')
      @builds = {}
      @deploys = {}
      @deploy_systems = []
      @build_systems = []
      super args
    end

    #
    # Methods invoked by CarryAll
    def has_build(name)
      carry_all.register self, :has_build, name
    end

    def add_build(build)
      builds[build.name] = build
    end

    def add_build_system(build_system)
      build_systems << build_system
    end

    def has_deploy(name)
      carry_all.register self, :has_deploy, name
    end

    def add_deploy(deploy)
      deploys[deploy.name] = deploy
    end

    #
    # DSL
    def is_hosted_on(name)
      carry_all.register self, :is_hosted_on, name
    end

    def deploys_from(name)
      carry_all.register self, :deploys_from, name
    end

  end
end
