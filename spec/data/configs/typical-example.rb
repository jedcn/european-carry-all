source_system 'github/jedcn' do
  hosts_projects_at '"https://github.com/jedcn/#{name}.git"'
end

build_system 'travis/jedcn' do
  url_is 'https://travis-ci.org/jedcn'
  hosts_projects_at '"#{url}/#{name}/"'
end

project 'defaults' do
  builds_in 'travis/jedcn'
  is_hosted_on 'github/jedcn'
  #is_hosted on: 'github', owner: 'jedcn'
end

project 'reveal-ck' do
  has_build 'reveal-ck'
end

project 'reveal-ck-template'

project 'rake-to-web' do
  has_build 'rake-to-web'
end

project 'emacs-setup'

project 'european-carry-all'
