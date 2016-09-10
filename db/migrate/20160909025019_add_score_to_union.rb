class AddScoreToUnion < ActiveRecord::Migration
  def change
    add_column :unions, :score, :decimal, precision: 5, scale:4
  end
end
