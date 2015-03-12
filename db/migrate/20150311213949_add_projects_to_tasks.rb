class AddProjectsToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :project, :string
  end
end
