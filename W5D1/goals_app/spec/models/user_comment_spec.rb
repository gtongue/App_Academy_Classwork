require 'rails_helper'

RSpec.describe UserComment, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:user_id)}
    it {should validate_presence_of(:poster_id)}
    it {should validate_presence_of(:body)}

    it {should belong_to(:user)}
    it {should belong_to(:poster)}
  end
end
