# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sentry/motion/version'

Gem::Specification.new do |spec|
  spec.name          = "sentry-motion"
  spec.version       = "0.1.0"
  spec.authors       = ["Manuel Pineyro"]
  spec.email         = ["manuel.o.pineyro@gmail.com"]

  spec.summary       = %q{Sentry for RubyMotion.}
  spec.homepage      = "https://github.com/mopineyro/sentry-motion"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
 
  spec.require_paths = ["lib"]

  spec.add_runtime_dependy "motion-cocoapods"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
end
