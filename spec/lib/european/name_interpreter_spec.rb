require 'spec_helper'

module European

  describe NameInterpreter do

    let :name do
      'prefix/actual/name'
    end

    let :name_interpreter do
      NameInterpreter.new name
    end

    it 'knows how to interpret a european name' do
      expect(name_interpreter.prefix).to eq 'prefix'
      expect(name_interpreter.name).to eq 'actual/name'
    end

  end

end
