class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :question_id, :null => false
      t.integer :user_id, :default => nil

      t.timestamps
    end
  end
end
