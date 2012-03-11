class AddNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :text, :null => false
  end
end
