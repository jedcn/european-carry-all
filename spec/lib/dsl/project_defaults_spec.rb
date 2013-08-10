require 'spec_helper'

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
    projects['reveal-ck']
  end

  let :travis do
    carry_all.build_systems['travis/jedcn']
  end

  describe 'enables all projects to share default settings' do

    it 'supports "builds_in"' do

      # reveal_ck knows about travis/jedcn
      expect(reveal_ck.build_system).to eq travis

      # travis/jedcn has been told of reveal_ck
      expect(travis.projects.values).to include reveal_ck

      # reveal_ck has a single build
      reveal_ck_build = reveal_ck.builds['reveal-ck']
      expect(reveal_ck.builds.size).to eq 1

      # The build's name has been set
      expect(reveal_ck_build.name).to eq 'reveal-ck'

      # The build is aware of the project that it belongs to
      expect(reveal_ck_build.project).to eq reveal_ck

      # The build is aware of the build system that it belongs to
      expect(reveal_ck_build.build_system).to eq travis

      # travis knows about the build
      expect(travis.builds['reveal-ck']).to eq reveal_ck_build
    end

    it 'supports "is_hosted_on"' do
      expect(reveal_ck.src_url).to eq 'https://github.com/jedcn/reveal-ck.git'
    end

  end

end
