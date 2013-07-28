module European

  class NamedCarryAllItem

    attr_reader :name

    def initialize(args)
      @name = args[:name] || raise(':name is required')
      @proc = args[:proc]
    end

    def setup
      instance_eval &@proc if @proc
    end

  end
end
