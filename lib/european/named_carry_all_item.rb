module European

  class NamedCarryAllItem

    attr_reader :name, :proc

    def initialize(args)
      @name = args[:name] || raise(':name is required')
      @proc = args[:proc]
    end

    def setup
      instance_eval &@proc if @proc
    end

    def exec(proc)
      instance_eval &proc
    end

    def to_s
      "#{self.class} '#{name}'"
    end

  end
end
