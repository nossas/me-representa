class AddDocumentsToCandidate < ActiveRecord::Migration
  def change
    add_column :candidates, :cpf, :string
    add_column :candidates, :titulo_eleitoral, :string
  end
end
