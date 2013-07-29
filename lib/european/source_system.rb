module European

  class SourceSystem < NamedCarryAllItem

    attr_reader :projects

    attr_reader :project_path

    def initialize(args)
      super args
      @projects = {}
    end

    def to_s
      "SourceSystem '#{name}'"
    end

    #
    # Methods invoked by CarryAll
    def src_url_for_project_named(name)
      eval project_path
    end

    def add_project(project)
      projects[project.name] = project
    end

    #
    # DSL
    def hosts_projects_at(project_path)
      @project_path = project_path
    end

  end

end
