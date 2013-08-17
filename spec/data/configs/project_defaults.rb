source_system 'github' do
  hosts_projects_at '"https://github.com/jedcn/#{name}.git"'
end

build_system 'travis-jedcn' do
  url_is 'https://travis-ci.org/jedcn'
  hosts_projects_at '"#{url}/#{name}/"'
end

project 'defaults' do
  is_hosted_on 'github'
end

project 'reveal-ck' do
  has_build 'travis-jedcn/reveal-ck'
end
