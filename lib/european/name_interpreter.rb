module European
  class NameInterpreter

    def initialize(name)
      @name = name
    end

    def prefix
      @name[0..@name.index('/')-1]
    end

    def name
      @name[@name.index('/')+1..-1]
    end

  end
end
