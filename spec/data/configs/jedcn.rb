build_server 'travis/jedcn' do
  root_url_is 'https://travis-ci.org/jedcn'
  is_a_travis
end

project_host 'github/jedcn' do
  root_url_is 'https://github.com/jedcn'
  is_a_github
end

project_defaults_for 'jedcn' do
  source_code_is_at 'github/jedcn'
end

project 'jedcn/reveal-ck' do
  has_build_at 'travis/jedcn'
end

project 'jedcn/reveal-ck-template'

project 'jedcn/rake-to-web' do
  has_build_at 'travis/jedcn'
end

project 'jedcn/emacs-setup'
