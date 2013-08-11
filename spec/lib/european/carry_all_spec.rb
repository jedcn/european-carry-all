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

      it 'has #projects' do
        carry_all.should respond_to :projects
      end

      it 'has #build_systems' do
        carry_all.should respond_to :build_systems
      end

      it 'has #source_systems' do
        carry_all.should respond_to :source_systems
      end

    end
  end
end
