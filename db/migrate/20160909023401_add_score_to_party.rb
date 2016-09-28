class AddScoreToParty < ActiveRecord::Migration
  def change
    add_column :parties, :score, :decimal, precision: 3, scale:2
  end
end
