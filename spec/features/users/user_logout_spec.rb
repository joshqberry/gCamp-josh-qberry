require 'rails_helper'

describe 'Checks for successful logout functionality' do

  before :each do
    @user = User.create(id: 42, first_name: 'Josh', last_name: 'Qberry', email: "josh@memail.com",
    password: "foobar", password_confirmation: "foobar")
  end

    it '-- Allows valid user who has logged in to log out' do

    visit '/login'

    fill_in 'Email', :with => @user.email

    fill_in 'Password', :with => @user.password

    click_on "Log in"

    # Tests for redirect
    expect(page).to have_content "Josh Qberry"

    visit '/users'

    click_on "Sign Out"

    # Tests for flash message
    expect(page).to have_content "Logged"
    # Tests for redirect
    expect(page).to have_content "Password"

    click_on "Projects"

    # Tests for flash message
    expect(page).to have_content "access"
    # Tests for restricted access now that user has logged out
    expect(page).to have_content "Password"

  end


end
