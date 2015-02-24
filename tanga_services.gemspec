# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tanga_services/version'

Gem::Specification.new do |spec|
  spec.name          = "tanga_services"
  spec.version       = TangaServices::VERSION
  spec.authors       = ["Joe Van Dyk"]
  spec.email         = ["joe@tanga.com"]
  spec.summary       = %q{Common things shared by tanga services / apps}
  spec.description   = %q{Read Summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'grape'
  spec.add_dependency 'activesupport', "> 4"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
end
