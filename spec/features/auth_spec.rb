require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign Up"
  end


  feature "signing up a user" do
    before(:each) do
      visit new_user_url
    end

    scenario "validates the presence of a username" do
      click_button 'Create User'
      expect(page).to have_content 'Sign Up'
      expect(page).to have_content "Username can't be blank"
    end

    scenario "rejects a blank password" do
      click_button 'Create User'
      expect(page).to have_content 'Sign Up'
      expect(page).to have_content 'Password is too short'
    end

    scenario "validates that the password is at least 6 characters long" do
      fill_in "Username", with: "HenryHenry"
      fill_in "Password", with: "passw"
      click_button 'Create User'
      expect(page).to have_content 'Sign Up'
      expect(page).to have_content 'Password is too short'
    end

    scenario "redirects to goal index page after signup" do
      sign_up_as_henry_henry
      expect(page).to have_content "Goals"
    end

    scenario "shows username on the homepage after signup" do
      sign_up_as_henry_henry
      expect(page).to have_content "HenryHenry"
    end

  end

end

feature "signing in" do
  before(:each) do
    visit new_session_url
  end

  scenario "validates the presence of the users's username" do
    save_and_open_page
    click_button "Sign In"
    expect(page).to have_content "Sign In"
    expect(page).to have_content "Invalid Username or Password"
  end

  scenario "validates the password" do
    fill_in "Username", with: "HenryHenry"
    fill_in "Password", with: "literally anything"
    click_button "Sign In"
    expect(page).to have_content "Sign In"
    expect(page).to have_content "Invalid Username or Password"
  end

  feature "with valid account information" do
    before(:each) do
      sign_up_as_henry_henry
    end

    scenario "shows Sign Out button when logged in" do
      expect(page).to have_content "Sign Out"
    end

    scenario "redirects to goals index page on success" do
      expect(page).to have_content "Sign Out"
      click_button "Sign Out"
      sign_in_as_henry_henry
      expect(page).to have_content "Goals"
    end

    scenario "shows username on the homepage after login" do
      expect(page).to have_content "HenryHenry"
    end
  end

end

feature "signing out" do

  scenario "begins with logged out state" do
    visit new_session_url
    expect(page).to_not have_content "Sign Out"
  end

  before(:each) do
    sign_up_as_henry_henry
  end

  scenario "doesn't show username on the homepage after logout" do
    click_button "Sign  Out"
    expect(page).to_not have_content "HenryHenry"
  end

end
