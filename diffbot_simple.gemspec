# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'diffbot_simple/version'

Gem::Specification.new do |spec|
  spec.name          = "diffbot_simple"
  spec.version       = DiffbotSimple::VERSION
  spec.authors       = ["Lars Krantz"]
  spec.email         = ["lars.krantz@alaz.se"]
  spec.summary       = %q{A simple, nothing-fancy, helper for the Diffbot API}
  # spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.required_ruby_version = "~> 2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "autotest-standalone"
  spec.add_development_dependency "webmock", "~> 1.17"

  spec.add_runtime_dependency "rest-core", "~> 2.1"
  spec.add_runtime_dependency "multi_json"

end
