class RemoveDuplicateColumnsFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :duedate
    remove_column :tasks, :checkbox
  end
end
