class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :question_id
      t.integer :responder_id
      t.string :responder_type
      t.string :short_answer
      t.text :long_answer

      t.timestamps
    end
  end
end
