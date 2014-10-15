require "rubygems"
gem "minitest"
require 'minitest/autorun'

$LOAD_PATH.unshift("#{File.dirname(__FILE__)}")
require "test_helper"
require "sub_cipher"

class TestByte < Minitest::Test
  def test_should_encode_and_decode_with_default_seed
    sc = SubCipher.gen()
    target_str = 'In cryptography, a substitution cipher is a method of encoding by which units of plaintext are replaced with ciphertext, according to a regular system; the "units" may be single letters (the most common), pairs of letters, triplets of letters, mixtures of the above, and so forth. The receiver deciphers the text by performing an inverse substitution.'
    encoded_str = sc.encode(target_str)
    decoded_str = sc.decode(encoded_str)
    assert_equal(decoded_str, target_str)
    assert_equal(sc.seed, ('a'..'z').to_a.join)
    assert_match(/^[a-z]*$/, sc.map)
  end

  def test_should_encode_and_decode_with_keep_case_false
    sc = SubCipher.gen(:keep_case => false)
    target_str = 'In cryptography, a substitution cipher is a method of encoding by which units of plaintext are replaced with ciphertext, according to a regular system; the "units" may be single letters (the most common), pairs of letters, triplets of letters, mixtures of the above, and so forth. The receiver deciphers the text by performing an inverse substitution.'
    encoded_str = sc.encode(target_str)
    decoded_str = sc.decode(encoded_str)
    assert_equal(decoded_str, target_str)
    assert_equal(sc.seed, [('a'..'z').to_a, ('a'..'z').to_a.map{ |a| a.upcase }].flatten.sort.join)
    assert_match(/^[a-zA-Z]*$/, sc.map)

    sc = SubCipher.gen(:k => false)
    target_str = 'In cryptography, a substitution cipher is a method of encoding by which units of plaintext are replaced with ciphertext, according to a regular system; the "units" may be single letters (the most common), pairs of letters, triplets of letters, mixtures of the above, and so forth. The receiver deciphers the text by performing an inverse substitution.'
    encoded_str = sc.encode(target_str)
    decoded_str = sc.decode(encoded_str)
    assert_equal(decoded_str, target_str)
  end

  def test_should_encode_the_given_seed_only
    seed = "abc"
    sc = SubCipher.gen(:seed => seed)
    target_str = "aaabbbcccdddeee"
    encoded_str = sc.encode(target_str)
    assert_match(/^[abc]{9}dddeee$/, encoded_str)
    assert_equal(sc.seed, seed.chars.sort.join)
    assert_match(/^[abc]*$/, sc.map)

    sc = SubCipher.gen(:s => seed)
    target_str = "aaabbbcccdddeee"
    encoded_str = sc.encode(target_str)
    assert_match(/^[abc]{9}dddeee$/, encoded_str)
  end

  def test_should_encode_with_the_given_map
    map = "bca"
    sc = SubCipher.gen(:map => map)
    target_str = "aaabbbcccdddeee"
    encoded_str = sc.encode(target_str)
    assert(encoded_str == "bbbcccaaadddeee")
    assert_equal(sc.seed, map.chars.to_a.uniq.sort.join)
    assert_match(/^[abc]*$/, sc.map)

    sc = SubCipher.gen(:m => map)
    target_str = "aaabbbcccdddeee"
    encoded_str = sc.encode(target_str)
    assert(encoded_str == "bbbcccaaadddeee")
  end

  def test_should_keep_the_case_by_default
    map = "bca"
    sc = SubCipher.gen(:map => map)
    target_str = "AAAbbbcccdddeee"
    encoded_str = sc.encode(target_str)
    assert(encoded_str == "BBBcccaaadddeee")
    assert_equal(sc.seed, map.chars.to_a.uniq.sort.join)
    assert_match(/^[abc]*$/, sc.map)
  end

  def test_should_mix_cases_if_keep_case_false
    seed = "abcABC"
    sc = SubCipher.gen(:seed => seed, :keep_case => false)
    target_str = "aaabbbcccdddeee"
    encoded_str = sc.encode(target_str)
    assert_match(/^[abcABC]{9}dddeee$/, encoded_str)
    assert_equal(sc.seed, seed.chars.sort.join)
  end

  def test_should_raise_unknown_option_exception
    e = assert_raises(SubCipher::SubCipherError) { SubCipher.gen(:unknown_option => "unknown_option") }
    assert(e.code == :unknown_option)
  end

  def test_should_raise_duplicated_option_exception
    e = assert_raises(SubCipher::SubCipherError) { SubCipher.gen(:map => "abc", :m => "def") }
    assert(e.code == :duplicated_option)
  end

  def test_should_raise_invalid_option_value_exception
    e = assert_raises(SubCipher::SubCipherError) { SubCipher.gen(:map => ["a","b","c"]) }
    assert(e.code == :invalid_option_value)
  end
end
