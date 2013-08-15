require 'spec_helper'

describe 'EuropeanCarryAll DSL' do

  describe 'project' do

    let :carry_all do
      European::CarryAll.load_file file
    end

    let :projects do
      carry_all.projects
    end

    describe 'project (without a block)' do

      let :file do
        File.join Dir.pwd, 'spec', 'data', 'configs', 'project.rb'
      end

      it 'brings a project into existence' do
        projects.size.should == 1
        reveal_ck = carry_all.project named: 'reveal-ck'
        reveal_ck.name.should == 'reveal-ck'
      end

    end

    describe 'project (with a block)' do

      let :file do
        File.join Dir.pwd, 'spec', 'data', 'configs', 'project-with-block.rb'
      end

      it 'brings a project into existence' do
        projects.size.should == 1
        reveal_ck = carry_all.project named: 'reveal-ck'
        reveal_ck.name.should == 'reveal-ck'
      end

      it 'instance evals the associated block' do
        reveal_ck = carry_all.project named: 'reveal-ck'
        reveal_ck.example.should == 1
      end

    end

  end

end
