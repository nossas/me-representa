class AddWeightToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :weight, :integer, :default => 1, :null => false
  end
end
