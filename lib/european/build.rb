module European
  class Build

    attr_reader :name, :build_system, :project, :url

    def initialize(args)
      @build_system = args[:build_system] || raise(':build_system is required')
      @project = args[:project] || raise(':project is required')
      @name = args[:name] || raise(':name is required')
      @url = args[:url] || raise(':url is required')
    end

    def to_s
      "Build '#{name}'"
    end

  end

end
