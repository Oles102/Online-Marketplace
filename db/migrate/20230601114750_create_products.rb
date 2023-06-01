class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.bigint  :user_id
      t.string  :name
      t.decimal :price
      t.text    :description
      t.string  :category

      t.timestamps
    end

    add_index :products, :user_id
    add_index :products, :category
  end
end
