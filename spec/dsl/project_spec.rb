require 'spec_helper'

describe 'EuropeanCarryAll DSL' do

  describe 'project' do

    let :carry_all do
      European::CarryAll.load_file file
    end

    let :projects do
      carry_all.projects
    end

    context 'with a single, simple project' do

      let :file do
        File.join Dir.pwd, 'spec', 'data', 'configs', 'project-simple.rb'
      end

      it 'knows how many projects are created' do
        projects.size.should == 1
      end

      it 'enables projects to be found by name' do
        reveal_ck = carry_all.projects['reveal-ck']
        reveal_ck.name.should == 'reveal-ck'
      end

    end

    context 'with a single project that has a block' do

      let :file do
        File.join Dir.pwd, 'spec', 'data', 'configs', 'project-block.rb'
      end

      it 'instance evals the associated block' do
        reveal_ck = carry_all.projects['reveal-ck']
        reveal_ck.example.should == 1
      end

    end

  end

end
