class AddBioToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :bio, :text
  end
end
