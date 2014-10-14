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
  spec.description   = <<-EOF
Usage:

Use default seeds(mixed-case alphabets, numbers, space, "," and ".") to generate the mapping

    sc = SubCipher.new
    sc.encode("Here is the secret.")
    #
    sc.decode("")
    # "Here is the secret."
    sc.map
    # ""
 
Only map the given seeds

    sc = SubCipher.new(seed: "abcde")
    sc.encode("Here is the secret.")
    # "Hcrc is tha scdrct."
    sc.decode("Hcrc is thc scdrct.")
    # "Here is the secret."
    sc.map
    # "bedac"

Initalize cipher with a map. Note that the `seed` option would be skipped if both `seed` and `map` options are given.

    sc = SubCipher.new(seed: "bedac")
    sc.encode("Here is the secret.")
    # "Hcrc is tha scdrct."
    sc.decode("Hcrc is thc scdrct.")
    # "Here is the secret."
    sc.map
    # "bedac"
 
Please see "README" to get more details.
EOF
  spec.homepage      = "https://github.com/sibevin/sub_cipher"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'minitest', '~> 5.0'
end
