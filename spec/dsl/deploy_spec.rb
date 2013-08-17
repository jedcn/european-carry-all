require 'spec_helper'

describe 'EuropeanCarryAll DSL' do

  describe 'deploy' do

    let :carry_all do
      European::CarryAll.load_file file
    end

    let :travis do
      carry_all.deploy_system named: 'jenkins'
    end


    describe 'deploy (without a block)' do

      let :file do
        File.join Dir.pwd, 'spec', 'data', 'configs', 'deploy.rb'
      end

      xit 'brings a deploy into existence' do
        reveal_ck.should_not be_nil
      end

      xit 'sets the deploy up with a nil project' do
        reveal_ck.project.should be_nil
      end

      xit 'sets the deploy up with a valid url' do
        reveal_ck.url.should == 'https://travis-ci.org/jedcn/reveal-ck/'
      end

    end

  end

end
