require 'rails_helper'

RSpec.describe User, type: :model do
  let(:available_balance) { 0.0 }
  let(:actual_balance) { 0.0 }
  let(:wallet) { create(:wallet, available_balance: available_balance, actual_balance: actual_balance) }
  let(:another_wallet) { create(:wallet, available_balance: 50.0, actual_balance: 50.0) }
  subject { wallet.user }

  it do
    expect(subject).to be_valid
    expect(wallet.available_balance).to eql(0.0)
  end

  context 'associations' do
    it { should have_one(:wallet) }
    it { should have_many(:user_transactions).class_name('Transaction') }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:phone) }
  end

  describe '#deposit_money' do
    it do
      subject.deposit_money(amount: 50.0)

      expect(wallet.available_balance).to eql(50.0)
      expect(wallet.actual_balance).to eql(50.0)
    end
  end

  describe '#withdraw_money!' do
    let(:available_balance) { 100.0 }
    let(:actual_balance) { 100.0 }

    it do
      subject.withdraw_money!(amount: 30.0)

      expect(wallet.available_balance).to eql(70.0)
      expect(wallet.actual_balance).to eql(70.0)
    end
  end

  describe '#transfer_money' do
    let(:available_balance) { 100.0 }
    let(:actual_balance) { 100.0 }

    it do
      subject.transfer_money(amount: 50.0, receiver: another_wallet.user)

      expect(wallet.available_balance).to eql(50.0)
      expect(another_wallet.available_balance).to eql(100.0)
    end
  end
end
