require 'rails_helper'

RSpec.describe Wallet, type: :model do
  subject { create(:wallet) }

  it do
    expect(subject).to be_valid
  end
end
