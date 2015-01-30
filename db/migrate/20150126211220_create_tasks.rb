class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.date :duedate
      t.boolean :checkbox
      t.timestamps null: false
    end
  end
end
