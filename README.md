# Sub(stitution) Cipher

[![Gem Version](https://badge.fury.io/rb/sub_cipher.png)][gem]
[![Build Status](https://travis-ci.org/sibevin/sub_cipher.png?branch=build)][travis]
[![Coverage Status](https://coveralls.io/repos/sibevin/sub_cipher/badge.png?branch=cover-check)][coveralls]

[gem]: https://rubygems.org/gems/sub_cipher
[travis]: https://travis-ci.org/sibevin/sub_cipher
[coveralls]:https://coveralls.io/r/sibevin/sub_cipher?branch=cover-check

Encode/Decode text with the substitution cipher

## Installation

    $ gem install sub_cipher

## Usage

Use default seeds(alphabets) to generate the mapping, note that the letters with different cases would be mapped to the same letter, for example: if "a" is mapped to "b", then "A" is mapped to "B".

    sc = SubCipher.gen
    sc.encode("Here is a secret.")
    # "Wyky gn q nyakyr."
    sc.decode("Wyky gn q nyakyr.")
    # "Here is a secret."
    sc.seed
    # "abcdefghijklmnopqrstuvwxyz"
    sc.map
    # "qeahyftwgpjixodzbknrlscvum"

The `seed` and `map` method shows how to map the cipher, the above example means mapping `"abcdefghijklmnopqrstuvwxyz"` to `"qeahyftwgpjixodzbknrlscvum"`

## Options

### Seed

Use `:s` (or `:seed`) to map the given seeds only

    sc = SubCipher.gen(seed: "abcde")
    sc.encode("Here is a secret.")
    # "Hcrc is e scbrct."
    sc.decode("Hcrc is e scbrct.")
    # "Here is a secret."
    sc.seed
    # "abcde"
    sc.map
    # "edbac"

### Map

Use `:m` (or `:map`) option to initalize cipher with a map. Note that the `:seed` option would be skipped if both `:seed` and `:map` options are given.

    sc = SubCipher.gen(seed: "bdeac")
    sc.encode("Here is a secret.")
    # "Hara is b saerat."
    sc.decode("Hara is b saerat.")
    # "Here is a secret."
    sc.seed
    # "abcde"
    sc.map
    # "bdeca"

### Keep Case

If you want to map letters with different cases to different letters, use `k: false` (or `keep_case: false`) option.

    sc = SubCipher.gen(keep_case: false)
    sc.encode("Here is a secret.")
    # "alXl wE s EleXlk."
    sc.decode("alXl wE s EleXlk.")
    # "Here is a secret."
    sc.seed
    # "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    sc.map
    # "PNAgWKOaxtCUdqHpIuJRhjTMnDsbeQlFiGwrzLfBvVYXEkZcoSmy"

If there is a seed(assigned by `seed` or `map` option) which is not an alphabet, `keep_case: false` would be applied.

    sc = SubCipher.gen(seed: "abcdeABCDE ,.")
    sc.encode("Here is a secret.")
    # "HdrdAisA,AsdBrdtE"
    sc.decode("HdrdAisA,AsdBrdtE")
    # "Here is a secret."
    sc.seed
    # " ,.ABCDEabcde"
    sc.map
    # "AaE ebCc,DB.d"

## Test

Go to gem folder and run

    ruby ./test/test_all.rb

(Note that you need minitest ~> 5.0 to run these tests)

## Contributing

1. Fork it ( https://github.com/sibevin/sub_cipher/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write tests for your code
4. Commit your changes (both code and tests) (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

## Authors

Sibevin Wang

## Copyright

Copyright (c) 2014 Sibevin Wang. Released under the MIT license.
