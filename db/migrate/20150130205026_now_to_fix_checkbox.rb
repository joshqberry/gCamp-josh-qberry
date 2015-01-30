class NowToFixCheckbox < ActiveRecord::Migration
  def change

    add_column :tasks, :checkboxer, :boolean

  end
end
