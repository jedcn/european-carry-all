require 'spec_helper'

describe 'EuropeanCarryAll DSL' do

  describe 'source_system' do

    let :carry_all do
      European::CarryAll.load_file file
    end

    let :source_systems do
      carry_all.source_systems
    end

    let :github_jedcn do
      source_systems['github/jedcn']
    end

    describe 'source_system (without a block)' do

      let :file do
        File.join Dir.pwd, 'spec', 'data', 'configs', 'source_system.rb'
      end

      it 'brings a source system into existence' do
        source_systems.size.should == 1
        github_jedcn.should_not be_nil
        github_jedcn.name.should == 'github/jedcn'
      end

    end

    describe 'source_system with a block' do

      let :file do
        File.join Dir.pwd, 'spec', 'data', 'configs', 'source_system-with-block.rb'
      end

      it 'brings a source system into existence' do
        source_systems.size.should == 1
        github_jedcn.should_not be_nil
        github_jedcn.name.should == 'github/jedcn'
      end

      it 'recognizes "hosts_projects_at"' do
        github_jedcn.project_path.should == '"https://github.com/jedcn/#{name}.git"'
      end

    end

  end

end
