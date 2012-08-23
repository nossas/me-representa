class AddTokenToCandidate < ActiveRecord::Migration
  def change
    add_column :candidates, :token, :string
  end
end
