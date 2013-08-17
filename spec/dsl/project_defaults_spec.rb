require 'spec_helper'

describe 'EuropeanCarryAll DSL' do

  describe 'project "defaults"' do

    let :file do
      File.join Dir.pwd, 'spec', 'data', 'configs', 'project_defaults.rb'
    end

    let :carry_all do
      European::CarryAll.load_file file
    end

    let :projects do
      carry_all.projects
    end

    let :reveal_ck do
      carry_all.project named: 'reveal-ck'
    end

    let :travis do
      carry_all.build_system named: 'travis/jedcn'
    end

    describe 'enables all projects to share default settings' do

      it 'supports "is_hosted_on"' do
        expect(reveal_ck.src_url).to eq 'https://github.com/jedcn/reveal-ck.git'
      end

    end

  end

end
