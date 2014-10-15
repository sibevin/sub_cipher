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

    sc = SubCipher.gen
    sc.encode("Here is a secret.")
    # "Wyky gn q nyakyr."
    sc.decode("Wyky gn q nyakyr.")
    # "Here is a secret."
    sc.seed
    # "abcdefghijklmnopqrstuvwxyz"
    sc.map
    # "qeahyftwgpjixodzbknrlscvum"
 
Use :s (or :seed) to map the given seeds only

    sc = SubCipher.gen(seed: "abcde")
    sc.encode("Here is a secret.")
    # "Hcrc is e scbrct."
    sc.decode("Hcrc is e scbrct.")
    # "Here is a secret."
    sc.seed
    # "abcde"
    sc.map
    # "edbac"

Use :m (or :map) option to initalize cipher with a map

    sc = SubCipher.gen(seed: "bdeac")
    sc.encode("Here is a secret.")
    # "Hara is b saerat."
    sc.decode("Hara is b saerat.")
    # "Here is a secret."
    sc.seed
    # "abcde"
    sc.map
    # "bdeca"

If you want to map letters with different cases to different letters, use "k: false" (or "keep_case: false") option.

    sc = SubCipher.gen(keep_case: false)
    sc.encode("Here is a secret.")
    # "alXl wE s EleXlk."
    sc.decode("alXl wE s EleXlk.")
    # "Here is a secret."
    sc.seed
    # "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    sc.map
    # "PNAgWKOaxtCUdqHpIuJRhjTMnDsbeQlFiGwrzLfBvVYXEkZcoSmy"
 
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
