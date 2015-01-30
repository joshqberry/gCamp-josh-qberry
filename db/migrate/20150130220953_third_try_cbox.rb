class ThirdTryCbox < ActiveRecord::Migration
  def change

    add_column :tasks, :cbox, :boolean


  end
end
