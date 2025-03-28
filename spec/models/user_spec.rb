require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }

  it do
    expect(subject).to be_valid
  end
end
