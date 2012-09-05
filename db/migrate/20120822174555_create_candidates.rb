class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :nickname
      t.integer :number
      t.integer :party_id
      t.boolean :male
      t.date :born_at

      t.timestamps
    end
  end
end
