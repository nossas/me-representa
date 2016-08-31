class AddCityIdToUnion < ActiveRecord::Migration
  def change
    add_column :unions, :city_id, :integer
  	add_foreign_key(:unions, :cities)
  end
end
