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
      @projects[project.name] = project
    end

    def register_build(project, name)
      raise 'Unknown project' unless @projects[project.name]
      build = Build.new build_system: self, name: name, url: "#{url}/#{name}"
      builds[project.name] ||= []
      builds[project.name] << build
      build
    end

  end

end
