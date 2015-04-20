require 'rails_helper'

RSpec.describe ProjectsController do

describe 'Valid, logged-in admin user should be able to access Projects controller actions' do

  before :each do
    @user = User.create(id: 42, first_name: "Josh", last_name: "Qberry", email: "josh@memail.com", password: "password", admin: true)
    session[:user_id] = @user.id
    @project = Project.create(id: 42, name: "Big project" )
  end

  it '-- Allows user to edit project' do
      put :update, {
        id: Project.find(42).id,
        project: {name: "Small project"}
      }
      @project.reload
      expect(@project.name).to eq("Small project")
    end
end
end
