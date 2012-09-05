class AddMobilePhoneToCandidate < ActiveRecord::Migration
  def change
    add_column :candidates, :mobile_phone, :string
  end
end
