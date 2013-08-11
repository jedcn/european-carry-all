require 'spec_helper'

describe 'EuropeanCarryAll DSL' do

  describe 'typical usage' do

    let :file do
      File.join Dir.pwd, 'spec', 'data', 'configs', 'typical-example.rb'
    end

    let :carry_all do
      European::CarryAll.load_file file
    end

    let :build_systems do
      carry_all.build_systems
    end

    let :source_systems do
      carry_all.source_systems
    end

    let :travis do
        build_systems['travis/jedcn']
    end

    let :github do
        source_systems['github/jedcn']
    end

    let :projects do
      carry_all.projects
    end

    describe 'known projects' do

      let :known_project_names do
        ['reveal-ck', 'reveal-ck-template', 'rake-to-web', 'emacs-setup', 'european-carry-all']
      end

      it 'includes every declared project' do
        projects.keys.should =~ known_project_names
      end

    end

    describe 'known build_systems' do

      let :known_build_systems do
        ['travis/jedcn']
      end

      it 'includes every declared build_system' do
        build_systems.keys.should =~ known_build_systems
      end

    end

    describe 'known source_systems' do

      let :known_source_systems do
        ['github/jedcn']
      end

      it 'includes every declared source_system' do
        source_systems.keys.should =~ known_source_systems
      end

    end

    describe 'created object graph' do

      it 'knits projects, source systems, build systems, and builds together' do

        reveal_ck = projects['reveal-ck']

        # The project's build_system has been set
        reveal_ck.build_system.should == travis

        # The build_system is aware of the project
        travis.projects.values.should include reveal_ck

        reveal_ck_build = reveal_ck.builds.values.first

        # The build's name has been set
        reveal_ck_build.name.should == 'reveal-ck'

        # The build is aware of the project that it belongs to
        reveal_ck_build.project.should == reveal_ck

        # The build is aware of the build system that it belongs to
        reveal_ck_build.build_system.should == travis

        # travis knows about the build
        travis.builds['reveal-ck'].should == reveal_ck_build

        # reveal_ck knows about its source system
        reveal_ck.source_system.should == github
        github.projects.values.should include reveal_ck
        reveal_ck.src_url.should == 'https://github.com/jedcn/reveal-ck.git'
      end

    end

  end

end
