class Api::V1::UsersController < ApplicationController
  before_action :permitted_params
  before_action :initialize_user
  before_action :validate_amount, only: [:deposit_money, :withdraw_money, :transfer_money]
  before_action :validate_receiver, only: [:transfer_money]

  DEFINED_PARAMS = {
    'deposit_money' => [:user_id, :amount],
    'withdraw_money' => [:user_id, :amount],
    'transfer_money' => [:user_id, :amount, :receiver_id],
    'wallet_balance' => [:user_id],
    'wallet_history' => [:user_id],
  }
  def deposit_money
    transaction = @user.deposit_money(amount: @amount)
    api_response = ApiResponse.new(
      transaction_type: 'deposit', transaction: transaction, balance: @user.available_balance
    )

    render json: api_response.response_message
  end

  def withdraw_money
    transaction = @user.withdraw_money!(amount: @amount)
    api_response = ApiResponse.new(
      transaction_type: 'withdraw', transaction: transaction, balance: @user.available_balance
    )

    render json: api_response.response_message
  rescue CustomExceptions => e
    render json: e.message
  end

  def transfer_money
    transaction = @user.transfer_money(amount: @amount, receiver: @receiver)
    api_response = ApiResponse.new(
      transaction_type: 'transfer', transaction: transaction, balance: @user.available_balance
    )

    render json: api_response.response_message
  end

  def wallet_balance
    render json: "Wallet available balance is $#{@user.available_balance}"
  end

  def wallet_history
    transactions = @user.wallet.transactions.order('created_at ASC')
    render json: TransactionSerializer.new(transactions).serializable_hash.to_json
  end

  def not_found(error_message: 'User not found')
    render json: error_message, status: :not_found
  end

  def invalid_input
    render json: 'Invalid input', status: :not_found
  end

  private
  def initialize_user
    @user = User.find_by(id: permitted_params[:user_id])

    validate_user
  end

  def validate_user
    return not_found if @user.nil?
  end

  def permitted_params
    params.permit(DEFINED_PARAMS[params[:action]])
  end

  def validate_amount
    @amount = permitted_params[:amount].to_f
    return invalid_input if !@amount.positive?
  end

  def validate_receiver
    @receiver = User.find_by(id: permitted_params[:receiver_id])

    return not_found(error_message: 'Receiver not found') if @receiver.nil?
  end
end
