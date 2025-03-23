class ApiResponse
  EMPTY_SPACE = ' '.freeze
  attr_accessor :transaction_type, :transaction, :balance
  def initialize(transaction_type:, transaction:, balance: nil)
    @transaction_type = transaction_type
    @transaction = transaction
    @balance = balance
  end

  def response_message
    message = if @transaction_type == 'deposit'
                deposit_message
              elsif @transaction_type == 'withdraw'
                withdraw_message
              elsif @transaction_type == 'transfer'
                transfer_message
              end

    [message, account_balance].join(EMPTY_SPACE)
  end

  def deposit_message
    "Successfully deposited money $#{@transaction.amount} into your account."
  end

  def withdraw_message
    "Successfully withdrawn money $#{@transaction.amount} from your account."
  end

  def transfer_message
    "Successfully transferred money $#{@transaction.amount} from your account to recipient."
  end

  def account_balance
    "Account balance is $#{balance}."
  end
end