guard :rspec, cli: '--color --format nested' do

  watch(%r{^spec/.+_spec\.rb$}) do |m|
    changed_spec = m[0]
    puts "Running something like 'rspec #{changed_spec}'."
    changed_spec
  end

  watch(%r{^lib/(.+)\.rb$}) do |m|
    changed_library = m[0]
    associated_spec = "spec/lib/#{m[1]}_spec.rb"
    puts "#{changed_library} has changed."
    puts "Running something like 'rspec #{associated_spec}'."
    associated_spec
  end

  watch('spec/spec_helper.rb') do |m|
    puts 'spec/spec_helper has changed. Running all specs.'
    puts "Running something like 'rspec spec'."
    'spec'
  end

end
