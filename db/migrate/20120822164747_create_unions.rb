class CreateUnions < ActiveRecord::Migration
  def change
    create_table :unions do |t|
      t.string :name

      t.timestamps
    end
  end
end
