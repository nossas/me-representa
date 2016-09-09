class AddNameNicknameEmailToTseData < ActiveRecord::Migration
  def change
    add_column :tse_data, :name, :string
    add_column :tse_data, :nickname, :string
    add_column :tse_data, :email, :string
    remove_column :tse_data, :electoral_title
  end
end
