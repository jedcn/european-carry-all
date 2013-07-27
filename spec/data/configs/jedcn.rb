
build_system 'travis' do
  url_is 'https://travis-ci.org/jedcn'
end

project 'reveal-ck' do

  builds_in 'travis'
  has_build 'travis/reveal-ck'

  @some_value = 1
  def some_value
    @some_value
  end

end

project 'rake-to-web' do
  builds_in 'travis'
  has_build 'travis/reveal-ck'
end

project 'reveal-ck-template'

project 'emacs-setup'
