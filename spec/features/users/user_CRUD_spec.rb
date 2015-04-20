require 'rails_helper'

describe 'Ensures users are able to CRU users' do

  before :each do
    @user = User.create(id: 42, first_name: 'Josh', last_name: 'Qberry', email: "josh@memail.com",
    password: "foobar", password_confirmation: "foobar")

    visit '/login'

    fill_in 'Email', :with => @user.email

    fill_in 'Password', :with => @user.password

    click_button "Log in"
  end

    it '-- Allows user to create user' do

    visit '/users/new'

    fill_in 'First name', :with => "Bill"

    fill_in 'Last name', :with => "Billerson"

    fill_in 'Email', :with => "bill@tedmail.com"

    fill_in 'Password', :with => "foobar"

    fill_in 'Confirm password', :with => "foobar"

    click_on "Create"

    # Tests for flash message
    expect(page).to have_content "successfully"
    # Tests for redirect
    expect(page).to have_content "New"
end

    it '-- Allows user to read user (see show page)' do

    visit '/users/new'

    fill_in 'First name', :with => "Bill"

    fill_in 'Last name', :with => "Billerson"

    fill_in 'Email', :with => "bill@tedmail.com"

    fill_in 'Password', :with => "foobar"

    fill_in 'Confirm password', :with => "foobar"

    click_on "Create"

    visit '/users'

    click_on "user"

    # Tests for redirect
    expect(page).to have_content "First name"
    end

    it '-- Allows user to edit user' do

    visit '/users/new'

    fill_in 'First name', :with => "Bill"

    fill_in 'Last name', :with => "Billerson"

    fill_in 'Email', :with => "bill@tedmail.com"

    fill_in 'Password', :with => "foobar"

    fill_in 'Confirm password', :with => "foobar"

    click_on "Create"

    page.first(:link, "Edit").click

    # Tests for redirect
    expect(page).to have_content "Password"

    fill_in 'Last name', :with => "Tedderson"

    click_on "Update"

    # Tests for flash message
    expect(page).to have_content "updated"
    # Tests for redirect
    expect(page).to have_content "New user"
    # Tests for sucessful edit
    expect(page).to have_content "Tedderson"

    end

describe 'Applies user CRUD validations' do

    it '-- Blocks user from creating user without providing first name' do

      visit '/users/new'

      fill_in 'Last name', :with => "Tedderson"

      fill_in 'Email', :with => "ted@tedmail.com"

      fill_in 'Password', :with => "foobar"

      fill_in 'Confirm password', :with => "foobar"

      click_button "Create"

      # Tests for validation message
      expect(page).to have_content "error"
      # Tests for NO redirect
      expect(page).to have_content "Password"

    end

    it '-- Blocks user from creating user without providing last name' do

      visit '/users/new'

      fill_in 'First name', :with => "Ted"

      fill_in 'Email', :with => "ted@tedmail.com"

      fill_in 'Password', :with => "foobar"

      fill_in 'Confirm password', :with => "foobar"

      click_button "Create"

      # Tests for validation message
      expect(page).to have_content "error"
      # Tests for NO redirect
      expect(page).to have_content "Password"

    end

    it '-- Blocks user from creating user without providing email address' do

      visit '/users/new'

      fill_in 'First name', :with => "Ted"

      fill_in 'Last name', :with => "Tedderson"

      fill_in 'Password', :with => "foobar"

      fill_in 'Confirm password', :with => "foobar"

      click_button "Create"

      # Tests for validation message
      expect(page).to have_content "error"
      # Tests for NO redirect
      expect(page).to have_content "Password"

    end

    it '-- Blocks user from creating user with already-taken email' do

      visit '/users/new'

      fill_in 'First name', :with => "Ted"

      fill_in 'Last name', :with => "Tedderson"

      fill_in 'Email', :with => "ted@tedmail.com"

      fill_in 'Password', :with => "foobar"

      fill_in 'Confirm password', :with => "foobar"

      click_button "Create"

      visit '/users/new'

      fill_in 'First name', :with => "Bill"

      fill_in 'Last name', :with => "Billerson"

      fill_in 'Email', :with => "ted@tedmail.com"

      fill_in 'Password', :with => "boobar"

      fill_in 'Confirm password', :with => "boobar"

      click_button "Create"

      # Tests for validation message
      expect(page).to have_content "error"
      # Tests for NO redirect
      expect(page).to have_content "Password"
    end

    it '-- Blocks user from creating user if password and password confirmation do not match' do

      visit '/users/new'

      fill_in 'First name', :with => "Ted"

      fill_in 'Last name', :with => "Tedderson"

      fill_in 'Email', :with => "ted@tedmail.com"

      fill_in 'Password', :with => "foobar"

      fill_in 'Confirm password', :with => "boobar"

      click_button "Create"

      # Tests for validation message
      expect(page).to have_content "error"
      # Tests for NO redirect
      expect(page).to have_content "Password"
    end
  end
end

#
#
# describe 'Ensures admin users' do
#
#   it '-- are able to delete users' do
#
#     @user = User.create(id: 1, first_name: 'Josh', last_name: 'Qberry', email: "josh@memail.com",
#     password: "foobar", password_confirmation: "foobar", admin: true)
#
#     visit '/login'
#
#     fill_in 'Email', :with => @user.email
#
#     fill_in 'Password', :with => @user.password
#
#     click_button "Log in"
#
#     expect(page).to have_content "Logged"
#
#
#     visit '/users/new'
#
#
#
#     fill_in 'First name', :with => "Bill"
#
#     fill_in 'Last name', :with => "Billerson"
#
#     fill_in 'Email', :with => "bill@tedmail.com"
#
#     fill_in 'Password', :with => "foobar"
#
#     fill_in 'Confirm password', :with => "foobar"
#
#     click_on "Create"
#
#     visit '/users'
#
#     page.first(:link, "Destroy").click
#
#     # Tests for flash message
#     expect(page).to have_content "destroyed"
#     # Tests for sucessful deletion
#     expect(page).to have_no_content "Billerson"
# end
#
# end
