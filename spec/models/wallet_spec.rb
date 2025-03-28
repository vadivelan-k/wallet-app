require 'rails_helper'

RSpec.describe Wallet, type: :model do
  let(:available_balance) { 50.0 }
  let(:actual_balance) { 50.0 }
  subject { create(:wallet, available_balance: available_balance, actual_balance: actual_balance) }
  let(:wallet_2) { create(:wallet) }

  it do
    expect(subject).to be_valid
  end

  context 'associations' do
    it { should have_many(:transactions) }
    it { should belong_to(:user) }
  end

  context 'validations' do
    it { should validate_presence_of(:wallet_type) }
  end

  describe '#deposit' do
    it do
      expect { subject.deposit(amount: 50.0, perform_by_id: subject.user_id) }.to change { Transaction.count }.by(1)

      expect(subject.available_balance).to eql(100.0)
    end
  end

  describe '#withdraw' do
    it do
      expect { subject.withdraw(amount: 50.0, perform_by_id: subject.user_id) }.to change { Transaction.count }.by(1)

      expect(subject.available_balance).to eql(0.0)
    end

    context 'without enough balance' do
      let(:available_balance) { 10.0 }
      let(:actual_balance) { 10.0 }

      it do
        expect { subject.withdraw(amount: 50.0, perform_by_id: subject.user_id) }.to raise_error(CustomExceptions::NotEnoughBalance)
      end
    end
  end

  describe '#transfer_money' do
    it do
      expect { subject.transfer_money(amount: 10.0, sender_id: subject.user_id, receiver: wallet_2.user) }.to change { Transaction.count }.by(2)

      expect(subject.available_balance).to eql(40.0)
      expect(wallet_2.available_balance).to eql(110.0)
    end
  end
end
