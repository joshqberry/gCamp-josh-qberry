class SecondTryForCheckbox < ActiveRecord::Migration
  def change

    change_column :tasks, :checkbox, :boolean


  end
end
