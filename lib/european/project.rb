module European
  class Project < NamedCarryAllItem

    attr_reader :carry_all

    attr_accessor :build_system

    attr_accessor :build

    def initialize(args)
      @carry_all = args[:carry_all] || raise(':carry_all is required')
      super args
    end

    def builds_in(name)
      carry_all.register self, :builds_in, name
    end

    def has_build(name)
      @build = build_system.register_build self, name
    end

  end
end
