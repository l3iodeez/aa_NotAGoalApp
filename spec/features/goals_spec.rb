require 'spec_helper'
require 'rails_helper'

feature "Adding Goals" do
  before(:each) do
    sign_up("fionafiona", "password")
  end

  scenario "User page has a link to add goals" do
    expect(page).to have_content "Add Goal"
  end

  feature "add goal form" do

    before(:each) do
      visit new_goal_url
    end

    scenario "The add form has fields for title, body, and privacy" do
      expect(page).to have_content "Title"
      expect(page).to have_content "Body"
      expect(page).to have_content "Private"
      expect(page).to have_content "Public"

    end

    scenario "Rejects a goal with no title" do
      click_button "Add Goal"
      expect(page).to have_content "Title can't be blank"
    end

    scenario "Accepts a goal with a body" do
      fill_in "Title", with: "Goal title"
      fill_in "Body", with: "This is the goal body"
      click_button "Add Goal"
      expect(page).to have_content "Goal title"
    end


    scenario "redirects to user page after creating a goal" do
      fill_in "Title", with: "Goal title"
      fill_in "Body", with: "This is the goal body"
      click_button "Add Goal"
      expect(page).to have_content "Goals"
      expect(page).to have_content "Goal title"
    end

    scenario "Only designated user can add to their goals" do
      click_button 'Sign Out'
      sign_up_as_henry_henry
      visit user_url(User.first)
      expect(page).to_not have_content "Add Goal"
    end

  end

end

feature "user page" do
  before(:each) do
    sign_up("fiona", "password")
    create_goal("Public Title", "this is how we do it", false)
  end

  scenario "shows users goals" do
    expect(page).to have_content "Public Title"
  end

  scenario "has a button to complete goals" do
    expect(page).to have_button "Complete Goal"
  end

  scenario "doesn't show completed goals" do
    click_button "Complete Goal"
    expect(page).to_not have_content "Public Title"
  end

  scenario "has a link to edit each goal" do
    expect(page).to have_content "Edit Goal"
  end

  scenario "has a button to delete each goal" do
    expect(page).to have_button "Delete Goal"
  end

  scenario "has a counter of all completed goals" do
    expect(page).to have_content "Completed Goals: 0"
    click_button "Complete Goal"
    expect(page).to have_content "Completed Goals: 1"
  end

  feature "a different user's page" do
    before(:each) do
      create_goal("Private Title", "private body")
      click_button 'Sign Out'
      sign_up_as_henry_henry
      visit user_url(User.first)
    end

    scenario "doesn't show private goals to other users" do
      expect(page).to have_content "Public Title"
      expect(page).to_not have_content "Private Title"
    end

    scenario "doesn't allow other users to edit or delete goals" do
      expect(page).to_not have_button "Delete Goal"
      expect(page).to_not have_content "Edit Goal"
    end

  end
end

feature "the public goal index" do
  before(:each) do
    sign_up_as_henry_henry
    create_goal("private", "body")
    create_goal("public", "body", false)
    click_button 'Sign Out'
    sign_up("factorygirl", "password")
    visit goals_url

  end

  scenario "doesn't show private goals" do
    expect(page).to have_content "public"
    expect(page).to_not have_content "private"
  end

  scenario "has a link to user's goal page" do
    expect(page).to have_content "My Goals"
  end

end
