# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "metahash/version"

Gem::Specification.new do |s|
  s.name        = "metahash"
  s.version     = MetaHash::VERSION
  s.platform    = Gem::Platform::RUBY
  s.license     = "MIT"
  s.authors     = ["L. Preston Sego III"]
  s.email       = "theprecognition+rubygems@gmail.com"
  s.homepage    = "https://github.com/NullVoxPopuli/MetaHash"
  s.summary     = "MetaHash-#{MetaHash::VERSION}"
  s.description = "Provides a subclass of Hash and a wrapper around Rails' serialize attribute for object-like access to hashes without validating existence of nested hashes."


  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]


  s.add_runtime_dependency "activerecord", ">= 4.0.0"
  s.add_development_dependency "bundler"
  s.add_development_dependency "rspec"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry-byebug"
  s.add_development_dependency "codeclimate-test-reporter"

end