class CreateOrderItems < ActiveRecord::Migration[8.0]
  def change
    create_table :order_items do |t|
      t.integer :order_id, null: false
      t.integer :item_id
      t.integer :product_id, null: false
      t.integer :quantity
      t.decimal :list_price, precision: 10, scale: 2
      t.decimal :discount, precision: 5, scale: 2

      t.timestamps
    end

    add_foreign_key :order_items, :orders, column: :order_id
    add_foreign_key :order_items, :products, column: :product_id
    add_index :order_items, :order_id
    add_index :order_items, :product_id
  end
end
