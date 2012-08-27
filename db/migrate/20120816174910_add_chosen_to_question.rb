class AddChosenToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :chosen, :boolean
  end
end
