# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'filestorage/version'

Gem::Specification.new do |spec|
  spec.name          = "filestorage"
  spec.version       = Filestorage::VERSION
  spec.authors       = ["takatoh"]
  spec.email         = ["takatoh.m@gmail.com"]
  spec.summary       = %q{A simple file storeage.}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 2.2.33"
  spec.add_development_dependency "rake"
end
