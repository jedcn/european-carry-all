require 'spec_helper'

describe 'EuropeanCarryAll DSL' do

  describe 'build_system' do

    let :carry_all do
      European::CarryAll.load_file file
    end

    let :build_systems do
      carry_all.build_systems
    end

    let :travis_jedcn do
      carry_all.build_system named: 'travis/jedcn'
    end

    describe 'build_system (without a block)' do

      let :file do
        File.join Dir.pwd, 'spec', 'data', 'configs', 'build_system.rb'
      end

      it 'brings a build system into existence' do
        build_systems.size.should == 1
        travis_jedcn.should_not be_nil
        travis_jedcn.name.should == 'travis/jedcn'
      end

    end

    describe 'build_system with a block' do

      let :file do
        File.join Dir.pwd, 'spec', 'data', 'configs', 'build_system-with-block.rb'
      end

      it 'brings a build system into existence' do
        build_systems.size.should == 1
        travis_jedcn.should_not be_nil
        travis_jedcn.name.should == 'travis/jedcn'
      end

      it 'recognizes "url_is"' do
        travis_jedcn.url.should == 'https://travis-ci.org/jedcn'
      end

      it 'recognizes "hosts_projects_at"' do
        travis_jedcn.project_path.should == '"#{url}/#{name}/"'
      end

    end

  end

end
