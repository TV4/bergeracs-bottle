# -*- encoding: utf-8 -*-
require File.expand_path('../lib/bergeracs-bottle/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Brian Riddle"]
  gem.email         = ["brian.riddle@tv4.se"]
  gem.description   = %q{Packages up some base functionality that we use in a couple of projects.}
  gem.summary       = %q{Used for rails models that aren't backed by a database but we still want validations and other rails nicities.}
  gem.homepage      = "http://github.com/TV4/bergeracs-bottle"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "bergeracs-bottle"
  gem.require_paths = ["lib"]
  gem.version       = Bergeracs::Bottle::VERSION
end
