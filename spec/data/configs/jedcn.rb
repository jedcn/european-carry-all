
build_system 'travis'

project 'reveal-ck' do

  builds_in 'travis'

  @some_value = 1
  def some_value
    @some_value
  end

end

project 'reveal-ck-template'
project 'rake-to-web'
project 'emacs-setup'
