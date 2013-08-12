require 'spec_helper'

describe 'EuropeanCarryAll DSL' do

  describe 'build' do

    let :carry_all do
      European::CarryAll.load_file file
    end

    let :travis do
      carry_all.build_systems['travis']
    end

    let :reveal_ck do
      travis.builds['jedcn/reveal-ck']
    end

    describe 'build (without a block)' do

      let :file do
        File.join Dir.pwd, 'spec', 'data', 'configs', 'build.rb'
      end

      it 'brings a build into existence' do
        reveal_ck.should_not be_nil
      end

      it 'sets the build up with a nil project' do
        reveal_ck.project.should be_nil
      end

      it 'sets the build up with a valid url' do
        reveal_ck.url.should == 'https://travis-ci.org/jedcn/reveal-ck/'
      end

    end

  end

end
