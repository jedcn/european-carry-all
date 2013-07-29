module European
  class Build

    attr_reader :name, :build_system, :project

    def initialize(args)
      @build_system = args[:build_system] || raise(':build_system is required')
      @project = args[:project] || raise(':project is required')
      @name = args[:name] || raise(':name is required')
    end
  end
end
