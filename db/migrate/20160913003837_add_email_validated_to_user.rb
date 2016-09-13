class AddEmailValidatedToUser < ActiveRecord::Migration
  def change
    add_column :users, :email_validated, :boolean
  end
end
