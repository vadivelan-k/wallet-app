class CustomExceptions < StandardError
  class NotEnoughBalance < CustomExceptions
    def message
      'Account does not have sufficient balance.'
    end
  end
end