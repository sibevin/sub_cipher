module SubCipher

  # A customized exception for SubCipher
  class SubCipherError < StandardError

    # Errors used in SubCipher
    ERRORS = {
      :unknown_option => {
        :value => 1,
        :msg => "Unknown option"
      },
      :duplicated_option => {
        :value => 2,
        :msg => "The same options are given."
      },
      :invalid_option_value => {
        :value => 3,
        :msg => "The given option value is invalid."
      },
    }

    attr_reader :code, :value, :msg, :info

    # The SubCipherError constructor.
    # @param error [Fixnum, String]
    #   You can give a error number defined in the keys of {SubCipher::SubCipherError::ERRORS} or a string message for internal usage.
    # @param info [Hash]
    #   Anything you want to put in the info attribute of SubCipherError.
    def initialize(error, info = {})
      @code = error
      @info = info
      if ERRORS.keys.include?(error)
        @value = ERRORS[error][:value]
        @msg = ERRORS[error][:msg]
      elsif error.class.name == 'String'
        @code = :internal
        @value = 90000
        @msg = error
      else
        @code = :internal
        @value = 99999
        @msg = "Internal Error"
      end
    end
  end
end
