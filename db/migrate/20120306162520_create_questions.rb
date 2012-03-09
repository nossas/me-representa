class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :text
      t.integer :user_id
      t.integer :category_id
      t.text :role_type

      t.timestamps
    end
  end
end
