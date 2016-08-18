class AddCityIdToCandidate < ActiveRecord::Migration
  def change
    add_column :candidates, :city_id, :integer
   	add_foreign_key(:candidates, :cities)
 end
end
