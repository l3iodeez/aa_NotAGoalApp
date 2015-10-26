require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New User"
  end


  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'Username', with: "testing_user"
      fill_in 'Password', with: "password"
      click_on "Create User"
    end

    scenario "redirects to goal index page after signup" do
      expect(page).to have_content "Goals"
    end

    scenario "shows username on the homepage after signup" do
      expect(page).to have_content "testing_user"
    end

  end

end

feature "logging in" do

  scenario "shows username on the homepage after login"

end

feature "logging out" do

  scenario "begins with logged out state"

  scenario "doesn't show username on the homepage after logout"

end
