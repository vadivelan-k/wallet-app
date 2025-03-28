require 'rails_helper'

RSpec.describe Transaction, type: :model do
  subject { create(:transaction) }

  it do
    expect(subject).to be_valid
  end

  context 'associations' do
    it { should belong_to(:wallet) }
    it { should belong_to(:perform_by).class_name('User') }
  end

  context 'validations' do
    it { should validate_presence_of(:transaction_type) }
    it { should validate_inclusion_of(:transaction_type).in_array(Transaction::TRANSACTION_TYPES) }
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount) }
    it { should validate_presence_of(:status) }
  end

  describe '#mark_as_completed' do
    it do
      subject.mark_as_completed

      expect(subject.status).to eql('completed')
    end
  end
end
