class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.string :symbol
      t.integer :number
      t.integer :union_id

      t.timestamps
    end
  end
end
