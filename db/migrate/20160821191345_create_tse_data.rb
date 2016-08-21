class CreateTseData < ActiveRecord::Migration
  def change
    create_table :tse_data do |t|
      t.string :cpf
      t.date :born_at
      t.integer :number
      t.boolean :male
      t.integer :party_id
      t.integer :city_id
      t.string :electoral_title
      t.timestamps
    end
    add_index :tse_data, :cpf, :unique => true
    add_index :tse_data, :electoral_title, :unique => true
  end
end
