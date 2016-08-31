class AddDocumentsToCandidate < ActiveRecord::Migration
  def change
    add_column :candidates, :cpf, :string
    add_column :candidates, :electoral_title, :string
  end
end
