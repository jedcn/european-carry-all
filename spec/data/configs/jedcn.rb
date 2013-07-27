
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

project 'reveal-ck-template'
project 'rake-to-web'
project 'emacs-setup'
