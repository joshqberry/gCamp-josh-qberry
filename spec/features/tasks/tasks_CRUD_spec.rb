require 'rails_helper'

describe 'Valid, logged-in user should be able to CRUD tasks' do

  before :each do
    @user = User.create(id: 42, first_name: 'Josh', last_name: 'Qberry', email: "josh@memail.com",
    password: "foobar", password_confirmation: "foobar")

    visit '/login'

    fill_in 'Email', :with => @user.email

    fill_in 'Password', :with => @user.password

    click_button "Log in"

    @project = Project.create(id: 42, name: "Big project")

    @membership = @project.memberships.create(user_id: 42, project_id: 42, role: "admin")

  end

      it '-- Allows valid, logged-in user to create task' do

      visit '/projects/42'

      # Tests for link to task creation page
      click_on "task"

      click_on "New Task"

      fill_in 'Description', :with => "Important task"

      select '2020', from: 'task_due_date_1i'

      select 'March', from: 'task_due_date_2i'

      select '15', from: 'task_due_date_3i'

      click_on "Create"

      # Tests for flash message
      expect(page).to have_content "successfully"
      # Tests for redirect away from Task new page
      expect(page).to have_no_content "Show"
      # Tests for redirect to Project show page
      expect(page).to have_content "1 task"
  end

      it '-- Allows valid, logged-in user to read task (see show page)' do

      visit '/projects/42/tasks'

      click_on "New Task"

      fill_in 'Description', :with => "Important task"

      select '2020', from: 'task_due_date_1i'

      select 'March', from: 'task_due_date_2i'

      select '15', from: 'task_due_date_3i'

      click_on "Create"

      click_on "1 task"

      click_on "Important"

      # Tests that link leaves project/1/tasks
      expect(page).to have_no_content "Destroy"
      # Tests for successful link to task show page
      expect(page).to have_content "Important"
      end

      it '-- Allows valid, logged-in user to edit task' do

      visit '/projects/42/tasks'

      click_on "New Task"

      fill_in 'Description', :with => "Important task"

      select '2020', from: 'task_due_date_1i'

      select 'March', from: 'task_due_date_2i'

      select '15', from: 'task_due_date_3i'

      click_on "Create"

      click_on "1 task"

      click_on "Edit"

      fill_in 'Description', :with => "Monumental task"

      check "if completed"

      click_on "Update"

      # Tests for flash message
      expect(page).to have_content "updated"
      # Tests for redirect away from Task edit page
      expect(page).to have_no_content "completed"
      # Tests for redirect to Project show page
      expect(page).to have_content "1 task"

      click_on "1 task"

      # Tests for sucessful edit
      expect(page).to have_content "Monumental"
      end

      it '-- Allows valid, logged-in user to delete task' do

        visit '/projects/42/tasks'

        click_on "New Task"

        fill_in 'Description', :with => "Important task"

        select '2020', from: 'task_due_date_1i'

        select 'March', from: 'task_due_date_2i'

        select '15', from: 'task_due_date_3i'

        click_on "Create"

        click_on "1 task"

        click_on ''

        # Tests for flash message
        expect(page).to have_content "deleted"
        # Tests for redirect to project show page
        expect(page).to have_content "0 tasks"

        click_on "0 tasks"

        # Tests for sucessful deletion
        expect(page).to have_no_content "Important"
  end

  describe 'Applies task CRUD validations' do

      it '-- Blocks valid, logged-in user from creating task without providing task description' do

      visit '/projects/42/tasks/new'

      click_on "Create"

      # Tests for validation message
      expect(page).to have_content "error"
      # Tests for NO redirect
      expect(page).to have_content "completed"
      end

  end

  end
