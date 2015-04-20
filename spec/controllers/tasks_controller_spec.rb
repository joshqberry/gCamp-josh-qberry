# require 'rails_helper'
#
# RSpec.describe TasksController do
#
# describe 'Valid, logged-in admin user should be able to access Tasks controller actions' do
#
#   before :each do
#     @project = Project.create(id: 42, name: "Big project" )
#     @task = Task.create(id: 42, description: "Cool task", due_date: "2015-03-11",
#     cbox: false, project_id: 42 )
#   end
#
#   it '-- Allows user to edit task' do
#     put :update, {
#         id: Task.find(42).id,
#         task: {description: "Lame task"}
#       }
#       @task.reload
#       expect(@task.name).to eq("Lame task")
#     end
# end
# end
