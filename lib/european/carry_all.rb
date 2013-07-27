module European

  class CarryAll

    attr_reader :projects

    def initialize
      @projects = {}
    end

    def setup
      projects.values.each { |project| project.setup }
    end

    def add_project(project)
      projects[project.name] = project
    end

  end
end


module European

  class CarryAll

    def self.load_file(file)
      carry_all = CarryAll.new
      lambda {
        Kernel.send :define_method, :project do |name, &block|
          carry_all.add_project European::Project.new name: name, block: block
        end
      }.call
      load file
      carry_all.setup
      carry_all
    end

  end
end
