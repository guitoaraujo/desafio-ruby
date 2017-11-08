class CreateProdutos < ActiveRecord::Migration[5.1]
  def change
    create_table :produtos do |t|
      t.string :nome
      t.string :preco
      t.string :parcelas
      t.string :imagem
      t.string :url

      t.timestamps
    end
  end
end
