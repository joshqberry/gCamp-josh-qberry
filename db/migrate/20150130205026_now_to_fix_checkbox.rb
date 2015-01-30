class NowToFixCheckbox < ActiveRecord::Migration
  def change

    add_column :tasks, :check_box, :boolean

  end
end
