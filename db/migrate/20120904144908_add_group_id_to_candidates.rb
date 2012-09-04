class AddGroupIdToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :group_id, :integer
  end
end
