class SecondTryForCheckbox < ActiveRecord::Migration
  def change

    change_column :tasks, :check_box, :boolean


  end
end
