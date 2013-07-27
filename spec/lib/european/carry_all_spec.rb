require 'spec_helper'

module European
  describe CarryAll do

    describe '.load_file "/path/to/a/carry-all-config.rb"' do

      let :file do
        File.join Dir.pwd, 'spec', 'data', 'configs', 'jedcn.rb'
      end

      it 'parses a file and returns a CarryAll' do
        result = CarryAll.load_file file
        expect(result).to be_a CarryAll
      end

    end

  end
end
