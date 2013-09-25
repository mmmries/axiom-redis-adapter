# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'axiom/adapter/redis/version'

Gem::Specification.new do |spec|
  spec.name          = "axiom-redis-adapter"
  spec.version       = Axiom::Adapter::Redis::VERSION
  spec.authors       = ["Michael Ries"]
  spec.email         = ["michael@riesd.com"]
  spec.description   = "A redis adapter for axiom. Intended to be used with ROM"
  spec.summary       = spec.description
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "redis", "~> 3.0"
  spec.add_runtime_dependency "rom", "~> 0.1"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 10.1"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "virtus", "~> 0.5.5"
  
end
