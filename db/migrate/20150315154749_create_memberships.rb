class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.string :role
      t.belongs_to :user, index: true
      t.belongs_to :project, index: true

      t.timestamps null: false
    end
    add_foreign_key :memberships, :users
    add_foreign_key :memberships, :projects
  end
end
