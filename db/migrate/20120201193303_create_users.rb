class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :email, :null => false

      t.timestamps
    end
  end
end
