module European
  class Project < NamedCarryAllItem

    attr_reader :carry_all

    attr_accessor :build_system

    def initialize(args)
      @carry_all = args[:carry_all]
      super args
    end

    def builds_in(name)
      carry_all.register self, :builds_in, name
    end

  end
end
