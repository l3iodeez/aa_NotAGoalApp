require 'spec_helper'
require 'rails_helper'

feature "commenting on users" do
  before(:each) do
    sign_up_as_henry_henry
  end

  scenario "User page has comment form" do
    expect(page).to have_content "Comment Body"
    expect(page).to have_button "Add Comment"
  end

  scenario "Requires a comment body" do
    click_button "Add Comment"
    expect(page).to have_content "Body can't be blank"
  end

  scenario "Adding a comment shows it on the user page" do
    fill_in "Comment Body", with: ":) you can do it"
    click_button "Add Comment"
    expect(page).to have_content ":) you can do it"
  end


end



feature "commenting on goals" do
  before(:each) do
    sign_up_as_henry_henry
    create_goal("Survive", "whatever, I don't know")
    click_on "Survive"
  end
  scenario "Goal show page title and body" do
    expect(page).to have_content "Survive"
    expect(page).to have_content "whatever, I don't know"
  end

  scenario "Goal page has comment form" do
    expect(page).to have_content "Comment Body"
    expect(page).to have_button "Add Comment"
  end

  scenario "Requires a comment body" do
    click_button "Add Comment"
    expect(page).to have_content "Body can't be blank"
  end

  scenario "Adding a comment shows it on the Goal page" do
    fill_in "Comment Body", with: ":) you can do it"
    click_button "Add Comment"
    expect(page).to have_content ":) you can do it"
  end

end
