require 'rails_helper'

RSpec.describe GoalsController, type: :controller do

  describe 'REST calls' do
    before(:each) do
      @user = FactoryBot.create(:user)
      controller.login(@user)
    end

    it 'renders new' do
        get :new, params: {id: @user.id}
        expect(response).to render_template('new')
    end

    it 'creates a new goal' do
      post :create, params: {goal: { goal: 'This is a goal!', id: @user.id}}
      expect(response).to redirect_to(users_url(@user.id))
    end

    it 'updates a goal' do
      post :create, params: {goal: { goal: 'This is a goal!', id: @user.id}}
      goal = Goal.last

      patch :update, params: {goal: { goal: 'New Goal!'}, id: goal.id}
      expect(response).to redirect_to(users_url(@user.id))
      expect(Goal.last.goal).to eq('New Goal!')
    end

  end
end
