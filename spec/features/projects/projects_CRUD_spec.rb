require 'rails_helper'

describe 'Valid, logged-in user should be able to CRUD projects' do

  before :each do
    @user = User.create(id: 1, first_name: 'Josh', last_name: 'Qberry', email: "josh@memail.com",
    password: "foobar", password_confirmation: "foobar")

    visit '/login'

    fill_in 'Email', :with => @user.email

    fill_in 'Password', :with => @user.password

    click_button "Log in"
  end

      it '-- Allows valid, logged-in user to create project' do

      visit '/projects/new'

      fill_in 'Name', :with => "Big project"

      click_on "Create"

      # Tests for flash message
      expect(page).to have_content "successfully"
      # Tests for redirect
      expect(page).to have_content "New Task"
  end

      it '-- Allows valid, logged-in user to read project (see show page)' do

      visit '/projects/new'

      fill_in 'Name', :with => "Big project"

      click_on "Create"

      # Tests for flash message
      expect(page).to have_content "successfully"
      # Tests for redirect
      expect(page).to have_content "New Task"

      visit "/projects"

      page.first(:link, "Big project").click

      # Tests for successful link to show page
      expect(page).to have_content "associated"
  end

      it '-- Allows valid, logged-in user to edit project' do

      visit '/projects/new'

      fill_in 'Name', :with => "Big project"

      click_on "Create"

      visit '/projects'

      page.first(:link, "Big project").click

      click_on "Edit"

      fill_in 'Name', :with => "Huge project"

      click_on "Update"

      # Tests for flash message
      expect(page).to have_content "updated"
      # Tests for redirect
      expect(page).to have_content "associated"
      # Tests for sucessful edit
      expect(page).to have_content "Huge"
      end

      it '-- Allows valid, logged-in admin user to delete project' do

    

      visit '/projects/new'

      fill_in 'Name', :with => "Big project"

      click_on "Create"

      visit '/projects'

      page.first(:link, "Big project").click

      click_on "Delete"

      # Tests for flash message
      expect(page).to have_content "destroyed"
      # Tests for sucessful deletion
      expect(page).to have_no_content "Big"
  end

  describe 'Applies project CRUD validations' do

      it '-- Blocks valid, logged-in user from creating project without providing project name' do

      visit '/projects/new'

      click_on "Create"

      # Tests for validation message
      expect(page).to have_content "error"
      # Tests for NO redirect
      expect(page).to have_content "Create"
      end

  end

  end
