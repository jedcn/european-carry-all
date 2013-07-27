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

      let :known_project_names do
        ['reveal-ck', 'reveal-ck-template', 'rake-to-web', 'emacs-setup']
      end

      describe '#projects' do

        let :projects do
          carry_all.projects
        end

        it 'returns a map of European::Projects in the CarryAll' do

          expect(projects.keys).to eq known_project_names

          expect(carry_all.projects.size).to eq 4

          carry_all.projects.values.each do |project|
            expect(project.class).to eq European::Project
          end

        end

      end

    end
  end
end
