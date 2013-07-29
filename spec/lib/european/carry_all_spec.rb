require 'spec_helper'

module European
  describe CarryAll do

    let :file do
      File.join Dir.pwd, 'spec', 'data', 'configs', 'jedcn.rb'
    end

    describe '.load_file "/path/to/a/carry-all-config.rb"' do

      it 'parses a file and returns a CarryAll' do
        result = CarryAll.load_file file
        expect(result).to be_a CarryAll
      end

    end

    describe 'an instantiated CarryAll' do

      let :carry_all do
        CarryAll.load_file file
      end

      let :projects do
        carry_all.projects
      end

      let :reveal_ck do
        projects['reveal-ck']
      end

      let :travis do
        carry_all.build_systems['travis/jedcn']
      end

      let :known_project_names do
        ['reveal-ck', 'reveal-ck-template', 'rake-to-web', 'emacs-setup']
      end

      describe '#projects' do

        it 'returns a map of European::Projects in the CarryAll' do

          expect(projects.keys).to match_array known_project_names

          carry_all.projects.values.each do |project|
            expect(project.class).to eq European::Project
          end

        end

      end

      it 'knits projects, source systems, build systems, and builds together' do
        # reveal_ck's build system has been set to travis
        expect(reveal_ck.build_system).to eq travis

        # travis has been told of reveal_ck
        expect(travis.projects.values).to include reveal_ck

        # reveal_ck has a single build
        reveal_ck_build = reveal_ck.builds['reveal-ck']
        expect(reveal_ck.builds.size).to eq 1

        # The build's name has been set
        expect(reveal_ck_build.name).to eq 'reveal-ck'
        # The build is aware of the project that it belongs to
        expect(reveal_ck_build.project).to eq reveal_ck
        # The build is aware of the build system that it belongs to
        expect(reveal_ck_build.build_system).to eq travis

        # travis knows about the build
        expect(travis.builds['reveal-ck']).to eq reveal_ck_build
        expect(reveal_ck.src_url).to eq 'https://github.com/jedcn/reveal-ck.git'
      end

    end
  end
end
