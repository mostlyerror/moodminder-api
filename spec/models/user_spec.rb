require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { create(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_uniqueness_of(:phone_number).case_insensitive.allow_nil }
  end

  describe 'phone number normalization' do
    it 'removes non-digit characters except plus sign' do
      user = create(:user, phone_number: '+1 (555) 123-4567')
      expect(user.phone_number).to eq('+15551234567')
    end

    it 'allows nil phone number' do
      user = create(:user, phone_number: nil)
      expect(user.phone_number).to be_nil
    end
  end
end
