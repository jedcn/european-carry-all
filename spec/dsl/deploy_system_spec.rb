require 'spec_helper'

describe 'EuropeanCarryAll DSL' do

  describe 'deploy_system' do

    let :carry_all do
      European::CarryAll.load_file file
    end

    let :deploy_systems do
      carry_all.deploy_systems
    end

    let :jenkins do
      carry_all.deploy_system named: 'jenkins'
    end

    describe 'deploy_system (without a block)' do

      let :file do
        File.join Dir.pwd, 'spec', 'data', 'configs', 'deploy_system.rb'
      end

      it 'brings a deploy system into existence' do
        deploy_systems.size.should == 1
        jenkins.should_not be_nil
        jenkins.name.should == 'jenkins'
      end

    end

    describe 'deploy_system with a block' do

      let :file do
        File.join Dir.pwd, 'spec', 'data', 'configs', 'deploy_system-with-block.rb'
      end

      it 'brings a deploy system into existence' do
        deploy_systems.size.should == 1
        jenkins.should_not be_nil
        jenkins.name.should == 'jenkins'
      end

      it 'recognizes "url_is"' do
        jenkins.url.should == 'https://jenkins.company.com'
      end

      it 'recognizes "hosts_projects_at"' do
        jenkins.project_path.should == '"#{url}/#{name}/"'
      end

    end

  end

end
