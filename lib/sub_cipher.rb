require "sub_cipher/sub_cipher_error"

module SubCipher
  # The alphabet seed
  ALPHABETS = ('a'..'z')

  # The supported options
  SUPPORTED_OPTS = {
    seed: {
      abbr: :s,
      type: String
    },
    map: {
      abbr: :m,
      type: String
    },
    keep_case: {
      abbr: :k
    },
  }

  # The default options
  DEFAULT_OPTS = {
    seed: [ALPHABETS.to_a, ALPHABETS.to_a.map{ |a| a.upcase }].flatten.join,
    keep_case: true
  }

  def SubCipher.gen(options = {})
    SubCipherObject.new(options)
  end

  class SubCipherObject
    def initialize(options)
      opts = check_opt(options)
      opts.each do |key, value|
        if (!SUPPORTED_OPTS.key?(key) && !SUPPORTED_OPTS.values.map {|v| v[:abbr]}.include?(key))
          raise SubCipherError.new(:unknown_option, key)
        end
        case key
        when :seed
          @map = value.chars.to_a.uniq.shuffle
        when :map
          @map = value.chars.to_a.uniq
        when :keep_case
          @keep_case = (value ? true : false)
        end
      end
      support_keep_case = true
      @map.each do |m|
        if !ALPHABETS.include?(m.downcase)
          support_keep_case = false
          break
        end
      end
      @keep_case = (support_keep_case && @keep_case ? true : false)
      if @keep_case
        @map = @map.map{ |m| m.downcase }.uniq
      end
      seed = @map.sort
      @mapping = {}
      seed.each_with_index do |s, index|
        @mapping[s] = @map[index]
      end
    end

    def encode(str)
      str.chars.map { |c| convert(c) }.join
    end

    def decode(str)
      str.chars.map { |c| convert(c, true) }.join
    end

    def map
      @map.join
    end

    def seed
      @map.sort.join
    end

    private
    def convert(char, reverse = false)
      if @keep_case
        if reverse
          if @mapping.value?(char)
            return @mapping.key(char)
          elsif @mapping.value?(char.downcase)
            return @mapping.key(char.downcase).upcase
          else
            return char
          end
        else
          if @mapping.key?(char)
            return @mapping[char]
          elsif @mapping.key?(char.downcase)
            return @mapping[char.downcase].upcase
          else
            return char
          end
        end
      else
        if reverse
          @mapping.value?(char) ? @mapping.key(char) : char
        else
          @mapping.key?(char) ? @mapping[char] : char
        end
      end
    end

    def check_opt(opts)
      SUPPORTED_OPTS.each do |key, value|
        if (opts[key] != nil) && opts.keys.include?(value[:abbr])
          raise SubCipherError.new(:duplicated_option, opts)
        end
        opts.merge!(key => opts[value[:abbr]]) if opts[value[:abbr]] != nil
        if (opts[key] != nil) && (value[:type] != nil) && !(opts[key]).is_a?(value[:type])
          raise SubCipherError.new(:invalid_option_value, opts)
        end
      end
      DEFAULT_OPTS.merge(opts)
    end
  end
end
