class SecondTryForCheckbox < ActiveRecord::Migration
  def change

    change_column :tasks, :checkboxer, :boolean

  end
end
