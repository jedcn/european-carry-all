build_system 'travis/jedcn' do
  url_is 'https://travis-ci.org/jedcn'
  hosts_projects_at '"#{url}/#{name}/"'
end
