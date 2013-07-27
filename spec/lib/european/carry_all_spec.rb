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
        carry_all.build_systems['travis']
      end

      let :known_project_names do
        ['reveal-ck', 'reveal-ck-template', 'rake-to-web', 'emacs-setup']
      end

      describe '#projects' do

        it 'returns a map of European::Projects in the CarryAll' do

          expect(projects.keys).to eq known_project_names

          expect(carry_all.projects.size).to eq 4

          carry_all.projects.values.each do |project|
            expect(project.class).to eq European::Project
          end

        end

        it 'instance evals the block associated with the project' do
          reveal_ck.some_value.should == 1
        end

      end

      it 'knits projects and builds together' do
        expect(reveal_ck.build_system).to eq travis
        expect(travis.projects.keys).to include reveal_ck.name
        expect(reveal_ck.build.url).to eq 'https://travis-ci.org/jedcn/reveal-ck'
      end

    end
  end
end
