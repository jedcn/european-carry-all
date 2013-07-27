module European

  class BuildSystem < NamedCarryAllItem

    attr_reader :projects

    def initialize(args)
      super args
      @projects = {}
    end

    def add_project(project)
      @projects[project.name] = project
    end

  end

end
