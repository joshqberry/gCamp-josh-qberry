require 'rails_helper'

RSpec.describe UsersController do

describe 'Valid, logged-in admin user should be able to access Users controller actions' do

  before :each do
    @user = User.create(id: 42, first_name: "Josh", last_name: "Qberry", email: "josh@memail.com", password: "password", admin: true)
    session[:user_id] = @user.id
  end

  it '-- Allows user to edit user' do
      put :update, {
        id: @user.id,
        user: {first_name: "ted"}
      }
      @user.reload
      expect(@user.first_name).to eq("ted")
    end
end
end
