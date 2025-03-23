class Api::V1::UsersController < ApplicationController
  before_action :permitted_params
  before_action :initialize_user
  before_action :validate_amount, only: [:deposit_money]
  def deposit_money
    transaction = @user.deposit_money(amount: permitted_params[:amount].to_f)
    api_response = ApiResponse.new(
      transaction_type: 'deposit', transaction: transaction, balance: @user.available_balance
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
    return invalid_input if permitted_params[:amount].to_f <= 0
  end
end
