require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'REST calls' do
    it 'renders new' do
      get :new, params: {}
      expect(response).to render_template('new')
    end

    it 'creates a user with valid params' do
      post :create, params: {user: {username: "username", password: "password"} }
      expect(response).to redirect_to(users_url(User.last))
    end

    it "doesn't create a user with invalid params" do
      post :create, params: { user:  {username: "username"} }
      expect(flash[:errors]).to be_present
      expect(response).to render_template('new')
    end
  end
end
