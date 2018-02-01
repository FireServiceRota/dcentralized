# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dcentralized/version'

Gem::Specification.new do |gem|
  gem.name          = "dcentralized-api"
  gem.version       = Dcentralized::VERSION
  gem.authors       = ["Nick den Engelsman"]
  gem.email         = ["nickdenengelsman@codedrops.nl"]
  gem.description   = %q{API wrapper for d-centralize.nl}
  gem.summary       = %q{Retreive data from the Pro6PP zipcode database}
  gem.homepage      = "https://github.com/corklaassebos/dcentralized"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "rest-client", ">= 1.6"
  gem.add_development_dependency "rspec", ">=2.13"
  gem.add_development_dependency "capybara", ">=2.1"
  gem.add_development_dependency "vcr", ">=2.4"
  gem.add_development_dependency "webmock", ">=1.8"
  gem.add_development_dependency "simplecov", ">= 0.7"
end
