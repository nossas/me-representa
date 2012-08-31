class AddFinishedAtToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :finished_at, :datetime
  end
end
