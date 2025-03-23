class Api::V1::UsersController < ApplicationController
  before_action :permitted_params
  before_action :initialize_user
  before_action :validate_amount, only: [:deposit_money, :withdraw_money]
  def deposit_money
    transaction = @user.deposit_money(amount: @amount)
    api_response = ApiResponse.new(
      transaction_type: 'deposit', transaction: transaction, balance: @user.available_balance
    )

    render json: api_response.response_message
  end

  def withdraw_money
    transaction = @user.withdraw_money(amount: @amount)
    api_response = ApiResponse.new(
      transaction_type: 'withdraw', transaction: transaction, balance: @user.available_balance
    )

    render json: api_response.response_message
  end

  def not_found
    render json: 'User not found', status: :not_found
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
    params.permit(:user_id, :amount)
  end

  def validate_amount
    @amount = permitted_params[:amount].to_f
    return invalid_input if !@amount.positive?
  end
end
