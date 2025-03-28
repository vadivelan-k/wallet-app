require 'rails_helper'

RSpec.describe Transaction, type: :model do
  subject { create(:transaction) }

  it do
    expect(subject).to be_valid
  end
end
