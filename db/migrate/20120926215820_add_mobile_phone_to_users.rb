class AddMobilePhoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mobile_phone, :integer
  end
end
