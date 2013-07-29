module European

  class BuildSystem < NamedCarryAllItem

    attr_reader :projects

    attr_reader :builds, :url

    def initialize(args)
      super args
      @projects = {}
      @builds = {}
    end

    def url_is(url)
      @url = url
    end

    def add_project(project)
      projects[project.name] = project
    end

    def add_build(build)
      builds[build.name] = build
    end

    def to_s
      "BuildSystem '#{name}'"
    end
  end

end
