# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'epa_uv_index/version'

Gem::Specification.new do |gem|
  gem.name          = "epa_uv_index"
  gem.version       = EpaUvIndex::VERSION
  gem.authors       = ["Greg Gershman"]
  gem.email         = ["greg@shelrick.com"]
  gem.description   = %q{Ruby client library for accessing the U.S. EPA's UV Index API (http://www.epa.gov/enviro/facts/services.html#uvindex)'}
  gem.summary       = %q{Get UV Index values by daily and hourly for zip code or city/state}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
