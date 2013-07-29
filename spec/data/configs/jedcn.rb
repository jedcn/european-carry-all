source_system 'github' do
  hosts_projects_at '"https://github.com/jedcn/#{name}.git"'
end

build_system 'travis/jedcn' do
  url_is 'https://travis-ci.org/jedcn'
  hosts_projects_at '"#{url}/#{name}/"'
end

project 'reveal-ck' do
  builds_in 'travis/jedcn'
  has_build 'reveal-ck'
  is_hosted_on 'github'
end

project 'rake-to-web' do
  builds_in 'travis/jedcn'
  has_build 'rake-to-web'
  is_hosted_on 'github'
end

project 'reveal-ck-template' do
  is_hosted_on 'github'
end

project 'emacs-setup' do
  is_hosted_on 'github'
end
