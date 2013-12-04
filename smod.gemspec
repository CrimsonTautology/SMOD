# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smod/version'

Gem::Specification.new do |spec|
  spec.name          = "smod"
  spec.version       = Smod::VERSION
  spec.authors       = ["CrimsonTautology"]
  spec.email         = ["billehs+github@gmail.com"]
  spec.description   = %q{SouceMod code generator}
  spec.summary       = %q{Build new plugins with ease}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rake"
  spec.add_dependency "thor"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "pry"
end
