
build_system 'travis/jedcn' do
  url_is 'https://travis-ci.org/jedcn'
end

project 'reveal-ck' do

  builds_in 'travis/jedcn'
  has_build 'reveal-ck'

  @some_value = 1
  def some_value
    @some_value
  end

end

project 'rake-to-web' do
  builds_in 'travis/jedcn'
  has_build 'reveal-ck'
end

project 'reveal-ck-template'

project 'emacs-setup'
