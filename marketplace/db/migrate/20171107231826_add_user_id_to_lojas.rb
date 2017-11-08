class AddUserIdToLojas < ActiveRecord::Migration[5.1]
  def change
    add_column :lojas, :user_id, :integer
  end
end
