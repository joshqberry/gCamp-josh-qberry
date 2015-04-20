# require 'test_helper'
#
# class UsersControllerTest < ActionController::TestCase
#
#   def log_in(user)
#       session[:user_id] = user.id
#   end
#
#   def setup
#     @user = users(:andyadmin)
#     log_in(@user)
#   end
#
#   test "should get index" do
#     get :index
#     assert_response :success
#   end
#
#   test "should get new" do
#     get :new
#     assert_response :success
#   end
#
#   test "should get edit" do
#
#     get edit_user_path(@user)
#     assert_response :success
#     assert_select "title", "#{@title}"
#   end
#
#   test "should get show" do
#     get :show
#     assert_response :success
#     assert_select "title", "#{@title}"
#   end
#
# end
