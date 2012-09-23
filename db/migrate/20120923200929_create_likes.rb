class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :candidate
      t.references :user

      t.timestamps
    end
    add_index :likes, :candidate_id
    add_index :likes, :user_id
  end
end
