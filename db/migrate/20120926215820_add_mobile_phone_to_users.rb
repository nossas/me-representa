class AddMobilePhoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mobile_phone, :string
  end
end
