# This migration was created in error, and the once-existing table in the database has been deleted.

class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :date
      t.string :location
      t.text :description
      t.integer :capacity
      t.boolean :requires_id

      t.timestamps null: false
    end
  end
end
