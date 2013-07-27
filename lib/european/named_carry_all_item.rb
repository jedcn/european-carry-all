module European

  class NamedCarryAllItem

    attr_reader :name

    def initialize(args)
      @name = args[:name] || raise(':name is required')
      @block = args[:block]
    end

    def setup
      instance_eval &@block if @block
    end

  end
end
