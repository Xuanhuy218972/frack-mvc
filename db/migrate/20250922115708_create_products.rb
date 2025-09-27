class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string  :name
      t.string  :brand
      t.integer :category_id
      t.integer :year
      t.decimal :price

      t.timestamps
    end
    add_index :products, :brand
    add_foreign_key :products, :categories, column: :category_id
  end
end
