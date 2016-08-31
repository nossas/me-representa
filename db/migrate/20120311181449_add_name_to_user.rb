class AddNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :text, default: nil
  end
end
