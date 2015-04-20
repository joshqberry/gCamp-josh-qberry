require 'rails_helper'

describe 'Checks for successful signup functionality' do

  it '-- Allows guest user to sign up' do

    visit '/signup'

    fill_in 'First name', :with => "Bill"

    fill_in 'Last name', :with => "Billerson"

    fill_in 'Email', :with => "bill@tedmail.com"

    fill_in 'Password', :with => "foobar"

    fill_in 'Confirm password', :with => "foobar"

    click_on "Sign up"

    # Tests for flash message
    expect(page).to have_content "successfully"
    # Tests for redirect
    expect(page).to have_content "Projects"
  end

    it '-- Blocks user from signing up without providing email address' do

      visit '/signup'

      fill_in 'First name', :with => "Ted"

      fill_in 'Last name', :with => "Tedderson"

      fill_in 'Password', :with => "foobar"

      fill_in 'Confirm password', :with => "foobar"

      click_button "Sign up"

      # Tests for validation message
      expect(page).to have_content "error"
      # Tests for NO redirect
      expect(page).to have_content "Password"

    end

    it '-- Blocks user from signing up with already-taken email' do

      visit '/signup'

      fill_in 'First name', :with => "Ted"

      fill_in 'Last name', :with => "Tedderson"

      fill_in 'Email', :with => "ted@tedmail.com"

      fill_in 'Password', :with => "foobar"

      fill_in 'Confirm password', :with => "foobar"

      click_button "Sign up"

      visit '/signup'

      fill_in 'First name', :with => "Bill"

      fill_in 'Last name', :with => "Billerson"

      fill_in 'Email', :with => "ted@tedmail.com"

      fill_in 'Password', :with => "boobar"

      fill_in 'Confirm password', :with => "boobar"

      click_button 'Sign up'

      # Tests for validation message
      expect(page).to have_content "error"
      # Tests for NO redirect
      expect(page).to have_content "Password"
    end

    it '-- Blocks user from signing up if password and password confirmation do not match' do

      visit '/signup'

      fill_in 'First name', :with => "Ted"

      fill_in 'Last name', :with => "Tedderson"

      fill_in 'Email', :with => "ted@tedmail.com"

      fill_in 'Password', :with => "foobar"

      fill_in 'Confirm password', :with => "boobar"

      click_button "Sign up"

      # Tests for validation message
      expect(page).to have_content "error"
      # Tests for NO redirect
      expect(page).to have_content "Password"
    end

end
