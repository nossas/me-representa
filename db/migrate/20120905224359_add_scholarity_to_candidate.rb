class AddScholarityToCandidate < ActiveRecord::Migration
  def change
    add_column :candidates, :scholarity, :string
  end
end
