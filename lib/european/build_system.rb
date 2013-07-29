module European

  class BuildSystem < NamedCarryAllItem

    attr_reader :projects, :builds

    attr_reader :url, :build_path

    def initialize(args)
      super args
      @projects = {}
      @builds = {}
    end

    def to_s
      "BuildSystem '#{name}'"
    end

    #
    # Methods invoked by CarryAll
    def url_for_build_named(name)
      eval build_path
    end

    def add_project(project)
      projects[project.name] = project
    end

    def add_build(build)
      builds[build.name] = build
    end

    #
    # DSL
    def url_is(url)
      @url = url
    end

    def builds_at(build_path)
      @build_path = build_path
    end

  end

end
