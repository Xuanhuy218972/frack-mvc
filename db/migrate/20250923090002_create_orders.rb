class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.integer :user_id, null: false
      t.integer :status, null: false
      t.date :order_date
      t.date :required_date
      t.date :shipped_date
      t.integer :store_id

      t.timestamps
    end
    
    add_foreign_key :orders, :users, column: :user_id
    add_index :orders, :user_id
    add_index :orders, :order_date
  end
end
