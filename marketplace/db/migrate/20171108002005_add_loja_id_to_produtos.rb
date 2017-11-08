class AddLojaIdToProdutos < ActiveRecord::Migration[5.1]
  def change
    add_column :produtos, :loja_id, :integer
  end
end
