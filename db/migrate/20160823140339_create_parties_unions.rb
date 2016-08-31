class CreatePartiesUnions < ActiveRecord::Migration
  def change
  	create_table "parties_unions", :id => false do |t|
	  	t.column "party_id", :integer, :null => false
	  	t.column "union_id",  :integer, :null => false
	end
  end
end
