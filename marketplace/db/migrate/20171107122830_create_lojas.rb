class CreateLojas < ActiveRecord::Migration[5.1]
  def change
    create_table :lojas do |t|
      t.string :nome
      t.string :website
      t.string :logo
      t.string :email

      t.timestamps
    end
  end
end
