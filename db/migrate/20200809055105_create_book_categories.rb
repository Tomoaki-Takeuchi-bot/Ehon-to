class CreateBookCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :book_categories do |t|
      t.integer :book_id
      t.integer :category_id

      t.timestamps
    end
    add_index :book_categories, :book_id
    add_index :book_categories, :category_id
    add_index :book_categories, [:book_id, :category_id], unique: true
  end
end
