# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'worktracker/version'

Gem::Specification.new do |gem|
  gem.name          = "worktracker"
  gem.version       = Worktracker::VERSION
  gem.authors       = ["Mattia Gheda"]
  gem.email         = ["ghedamat@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "sequel"
  gem.add_runtime_dependency "sqlite3"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "timecop"
  gem.add_development_dependency "awesome_print"
  gem.add_development_dependency "pry"
end
