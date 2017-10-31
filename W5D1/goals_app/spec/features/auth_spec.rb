require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit 'users'
    expect(page).to have_content 'Sign Up'
  end

  feature 'signing up a user' do
    scenario 'shows username on the homepage after signup' do
      visit 'users/new'
      within('#user') do
        fill_in 'Username', with: 'username'
        fill_in 'Password', with: 'password'
      end

      click_button 'Submit'
      expect(page).to have_content 'username'
    end
  end
end

feature 'logging in' do
  scenario 'shows username on the homepage after login' do
    sign_up('username')
    # visit users_url
    expect(page).to have_content 'username'
  end

end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    visit users_url
    expect(page).to have_content 'Sign In'
    expect(page).to have_content 'Sign Up'

  end
  scenario 'doesn\'t show username on the homepage after logout' do
    visit users_url
    expect(page).to_not have_content 'username'
  end
end
