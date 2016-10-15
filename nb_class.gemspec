# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nb_class/version'

Gem::Specification.new do |spec|
  spec.name          = "nb_class"
  spec.version       = NBClass::VERSION
  spec.authors       = ["Humberto Marchezi"]
  spec.email         = ["hcmarchezi@gmail.com"]
  spec.description   = "Machine learning text classifier"
  spec.summary       = "This gem offers a simplified interface to allow a text classifier to be trained by previous samples to identify different groups implemented with naïve bayes algorithm"
  spec.homepage      = "https://github.com/hcmarchezi/nb_class"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", '~> 0'
  spec.add_development_dependency "rspec", '~> 0'
  spec.add_development_dependency "debugger", '~> 0'
end
