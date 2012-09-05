class AddOccupationToCandidate < ActiveRecord::Migration
  def change
    add_column :candidates, :occupation, :string
  end
end
