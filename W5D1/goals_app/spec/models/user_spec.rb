require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:username)}
    it {should validate_presence_of(:password_digest)}
    # it {should validate_presence_of(:session_token)}

    it {should validate_length_of(:password).is_at_least(6)}
    it {should have_many(:goals)}
  end

  describe '::find_by_credentials' do
    user = FactoryBot.create(:user)
    it 'returns user with valid params' do
      expect(User.find_by_credentials(user.username, "password")).to eq(user)
    end

    it 'returns nil with invalid params' do
      expect(User.find_by_credentials(user.username, "pasdsfsword")).to_not be(user)
    end
  end

  describe '#ensure_session_token' do
    user = FactoryBot.build(:user)
    it 'has session token' do
      expect(user.session_token).to be_truthy
    end
  end
end
