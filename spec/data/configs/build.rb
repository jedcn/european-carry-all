build_system 'travis' do
  url_is 'https://travis-ci.org'
  hosts_projects_at '"#{url}/#{name}/"'
end

build 'travis/jedcn/reveal-ck'
build 'travis/jedcn/rake-to-web'
