class CreateTseData < ActiveRecord::Migration
  def change
    create_table :tse_data do |t|
      t.string :cpf
      t.date :born_at
      t.integer :number
      t.boolean :male
      t.integer :party_id
      t.integer :city_id
      t.string :electoral_title
      t.timestamps
    end
    # INFELIZMENTE O TSE NÃO PASSOU DADOS SUFICIENTEMENTE FIDEDIGNOS
    # Existem candidatos registrados duas vezes, com datas de nascimento
    # diferentes, sexo diferentes, e as vezes concorrendo com dois números
    # diferentes.
    # add_index :tse_data, [:number, :city_id], :unique => true
    # add_index :tse_data, :cpf, :unique => true
    # add_index :tse_data, :electoral_title, :unique => true
  end
end
