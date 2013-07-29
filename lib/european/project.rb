module European
  class Project < NamedCarryAllItem

    attr_reader :carry_all

    attr_accessor :build_system, :source_system

    attr_accessor :builds, :src_url

    def initialize(args)
      @carry_all = args[:carry_all] || raise(':carry_all is required')
      @builds = {}
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

    #
    # DSL
    def builds_in(name)
      carry_all.register self, :builds_in, name
    end

    def is_hosted_on(name)
      carry_all.register self, :is_hosted_on, name
    end

  end
end
