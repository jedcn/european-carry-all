module European
  class Project < NamedCarryAllItem

    attr_reader :carry_all

    attr_accessor :build_system

    attr_accessor :build

    def initialize(args)
      @carry_all = args[:carry_all]
      super args
    end

    def builds_in(name)
      carry_all.register self, :builds_in, name
    end

    def has_build(name)
      first_slash = name.index '/'
      build_system_name = name[0..first_slash-1]
      build_name = name[first_slash+1..name.size]
      @build = build_system.register_build self, build_name
    end

  end
end
