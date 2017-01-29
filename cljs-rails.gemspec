# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cljs/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "cljs-rails"
  spec.version       = Cljs::Rails::VERSION
  spec.authors       = ["Bogdan Dumitru"]
  spec.email         = ["dumbogdan@gmail.com"]
  spec.summary       = %q{Clojurescript integration for Rails, inspired by webpack-rails}
  spec.description   = %q{Boot powered helpers to get up and running fast with Clojurescript in your Rails application}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rails", ">= 3.2.0"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
