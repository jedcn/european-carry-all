deploy_system 'jenkins' do
  url_is 'https://jenkins.company.com'
  hosts_projects_at '"#{url}/jobs/#{name}/"'
end

build 'jenkins/server-deploy'

#jenkins1.roving.com/job/deploy-CI1-auth_platform/
