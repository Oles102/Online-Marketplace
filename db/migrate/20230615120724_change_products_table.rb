class ChangeProductsTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :category
    add_column :products, :category_id, :bigint
    add_index :products, :category_id
  end
end
