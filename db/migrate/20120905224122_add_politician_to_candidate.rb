class AddPoliticianToCandidate < ActiveRecord::Migration
  def change
    add_column :candidates, :politician, :boolean
  end
end
