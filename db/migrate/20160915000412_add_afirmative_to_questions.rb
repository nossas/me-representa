class AddAfirmativeToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :afirmative, :text
  end
end
