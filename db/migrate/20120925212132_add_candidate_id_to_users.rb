class AddCandidateIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :candidate_id, :integer, default: nil
  end
end
