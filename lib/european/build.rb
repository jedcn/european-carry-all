module European
  class Build

    attr_reader :name, :build_system, :url

    def initialize(args)
      @build_system = args[:build_system]
      @name = args[:name]
      @url = args[:url]
    end
  end
end
