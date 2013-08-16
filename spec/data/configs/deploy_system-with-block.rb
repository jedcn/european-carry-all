deploy_system 'jenkins' do
  url_is 'https://jenkins.company.com'
  hosts_projects_at '"#{url}/#{name}/"'
end
