build_system 'travis/jedcn' do
  url_is 'https://travis-ci.org/jedcn'
  builds_at '"#{url}/#{name}/"'
end

project 'reveal-ck' do
  builds_in 'travis/jedcn'
  has_build 'reveal-ck'
end

project 'rake-to-web' do
  builds_in 'travis/jedcn'
  has_build 'rake-to-web'
end

project 'reveal-ck-template'

project 'emacs-setup'
