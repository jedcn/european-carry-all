require 'spec_helper'

module European
  describe Project do

    let :name_of_project do
      'name_of_project'
    end

    describe '#new' do

      let :carry_all do
        double 'carry_all'
      end

      it 'requires a :name and a :carry_all' do
        expect(lambda {
                 Project.new({ name: name_of_project, carry_all: carry_all })
               }).to_not raise_error
      end

    end

    describe '#builds_in' do

      let :carry_all do
        double 'carry_all'
      end

      let :name_of_build_system do
        'name_of_build_system'
      end

      it 'registers the referenced build_system with the carry_all' do
        project = Project.new({ name: name_of_project, carry_all: carry_all })
        carry_all.should_receive(:register).with(project, :builds_in, name_of_build_system)
        project.builds_in name_of_build_system
      end

    end

    describe '#has_build' do

      let :carry_all do
        double 'carry_all'
      end

      let :name_of_build do
        'name_of_build'
      end

      let :project do
        Project.new({ name: name_of_project, carry_all: carry_all })
      end

      it 'registers the referenced build with the carry_all' do
        carry_all.should_receive(:register).with(project, :has_build, name_of_build)
        project.has_build name_of_build
      end

    end

    describe '#deploys_from' do

      let :carry_all do
        double 'carry_all'
      end

      let :name_of_deploy_system do
        'name_of_deploy_system'
      end

      let :project do
        Project.new({ name: name_of_project, carry_all: carry_all })
      end

      it 'registers the referenced deploy with the carry_all' do
        carry_all.should_receive(:register).with(project, :deploys_from, name_of_deploy_system)
        project.deploys_from name_of_deploy_system
      end

    end

    describe '#has_deploy' do

      let :carry_all do
        double 'carry_all'
      end

      let :name_of_deploy do
        'name_of_deploy'
      end

      let :project do
        Project.new({ name: name_of_project, carry_all: carry_all })
      end

      it 'registers the referenced build with the carry_all' do
        carry_all.should_receive(:register).with(project, :has_deploy, name_of_deploy)
        project.has_deploy name_of_deploy
      end

    end

  end

end
