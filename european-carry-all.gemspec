# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "european/version"

Gem::Specification.new do |s|
  s.name        = "european-carry-all"
  s.version     = European::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Jed Northridge']
  s.email       = ['northridge@gmail.com']
  s.homepage    = 'https://github.com/jedcn/european-carry-all'
  s.summary     = %q{A lightweight DSL for describing a project portfolio}
  s.description = %q{A scheme for describing project portfolios.}

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'rake'

  s.rubyforge_project = "european-carry-all"

  s.licenses = ['MIT']

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end
