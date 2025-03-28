require 'rails_helper'

RSpec.shared_examples 'block invalid user' do |action, user_id|
  it do
    get action, params: { user_id: user_id }

    expect(response).to have_http_status(404)
  end
end

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'get#wallet_balance' do
    let(:user) { create(:user) }

    it do
      get :wallet_balance, params: { user_id: user.id }

      expect(response).to have_http_status(200)
      expect(response.body).to eql('Wallet available balance is $0.0')
    end

    it_behaves_like 'block invalid user', :wallet_balance, 0
  end

  describe 'post#deposit_money' do
    let(:user) { create(:user) }

    let(:amount) { 50.0 }

    it do
      post :deposit_money, params: { amount: amount, user_id: user.id }

      expect(response).to have_http_status(200)
      expect(response.body).to eql('Successfully deposited money $50.0 into your account. Account balance is $50.0.')
    end

    it_behaves_like 'block invalid user', :deposit_money, 0
  end

  describe 'post#withdraw_money' do
    let(:user) { create(:user) }
    let(:deposit) { 100.0 }
    let(:withdraw) { 20.0 }

    it do
      user.deposit_money(amount: deposit)

      post :withdraw_money, params: { amount: withdraw, user_id: user.id }

      expect(response).to have_http_status(200)
      expect(response.body).to eql('Successfully withdrawn money $20.0 from your account. Account balance is $80.0.')
    end

    it_behaves_like 'block invalid user', :withdraw_money, 0
  end

  describe 'post#transfer_money' do
    let(:user) { create(:user) }
    let(:user_1) { create(:user) }
    let(:deposit) { 50.0 }
    let(:transfer) { 25.0 }

    it do
      user.deposit_money(amount: deposit)
      post :transfer_money, params: { amount: transfer, user_id: user.id, receiver_id: user_1.id }

      expect(response).to have_http_status(200)
      expect(response.body).to eql('Successfully transferred money $25.0 from your account to recipient. Account balance is $25.0.')
    end

    it_behaves_like 'block invalid user', :transfer_money, 0
  end

  describe 'get#wallet_history' do
    let(:user) { create(:user) }

    it do
      user.deposit_money(amount: 10.0)
      user.deposit_money(amount: 20.0)

      get :wallet_history, params: { user_id: user.id }

      transactions = user.wallet.transactions
      expected_json = TransactionSerializer.new(transactions).serializable_hash.as_json

      expect(JSON.parse(response.body)).to eql(expected_json)
    end

    it_behaves_like 'block invalid user', :wallet_history, 0
  end
end
