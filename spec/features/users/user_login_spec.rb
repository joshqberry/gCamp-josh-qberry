require 'rails_helper'

describe 'Checks for successful login functionality' do

  before :each do
    @user = User.create(id: 1, first_name: 'Josh', last_name: 'Qberry', email: "josh@memail.com",
    password: "foobar", password_confirmation: "foobar")
  end

    it '-- Allows valid user to sign in' do

    visit '/login'

    fill_in 'Email', :with => @user.email

    fill_in 'Password', :with => @user.password

    click_button "Log in"

    # Tests for flash message
    expect(page).to have_content "Logged"
    # Tests for redirect
    expect(page).to have_content "Josh Qberry"

  end

  it '-- Blocks user from signing in without providing email address ' do

  visit '/login'

  fill_in 'Password', :with => @user.password

  click_button "Log in"

  # Tests for flash message
  expect(page).to have_content "invalid"
  # Tests for NO redirect
  expect(page).to have_content "Password"


  end

  it '-- Blocks invalid user from signing in with incorrrect password ' do

  visit '/login'

  fill_in 'Email', :with => @user.email

  fill_in 'Password', :with => "boobar"

  click_button "Log in"

  expect(page).to have_content "invalid"

  # Tests for flash message
  expect(page).to have_content "invalid"
  # Tests for NO redirect
  expect(page).to have_content "Password"
  end

end
