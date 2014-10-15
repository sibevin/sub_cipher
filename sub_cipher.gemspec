# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sub_cipher/version'

Gem::Specification.new do |spec|
  spec.name          = "sub_cipher"
  spec.version       = SubCipher::VERSION
  spec.authors       = ["Sibevin Wang"]
  spec.email         = ["sibevin@gmail.com"]
  spec.summary       = %q{Encode/Decode text with substitution cipher}
  spec.description   = %q{Encode/Decode text with substitution cipher, please see "README" to get more details.}
  spec.homepage      = "https://github.com/sibevin/sub_cipher"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'minitest', '~> 5.0'
end
