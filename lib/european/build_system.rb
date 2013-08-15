module European

  class BuildSystem < NamedCarryAllItem

    attr_reader :url, :project_path

    def initialize(args)
      super args
      @projects = {}
      @builds = {}
    end

    #
    # Methods invoked by CarryAll
    def url_for_project_named(name)
      eval project_path
    end

    def add_project(project)
      @projects[project.name] = project
    end

    def add_build(build)
      @builds[build.name] = build
    end

    def projects()
      @projects.values
    end

    def project(args)
      named = args[:named] || raise('named is required')
      @projects[named]
    end

    def builds
      @builds.values
    end

    def build(args)
      named = args[:named] || raise('named is required')
      @builds[named]
    end

    #
    # DSL
    def url_is(url)
      @url = url
    end

    def hosts_projects_at(project_path)
      @project_path = project_path
    end

  end

end
