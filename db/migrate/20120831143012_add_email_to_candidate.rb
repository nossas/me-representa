class AddEmailToCandidate < ActiveRecord::Migration
  def change
    add_column :candidates, :email, :string
  end
end
