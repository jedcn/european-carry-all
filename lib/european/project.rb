module European
  class Project < NamedCarryAllItem

    attr_reader :carry_all

    attr_accessor :build_system

    attr_accessor :builds

    def initialize(args)
      @carry_all = args[:carry_all] || raise(':carry_all is required')
      @builds = {}
      super args
    end

    def builds_in(name)
      carry_all.register self, :builds_in, name
    end

    def has_build(name)
      carry_all.register self, :has_build, name
    end

    def add_build(build)
      builds[build.name] = build
    end
  end
end
