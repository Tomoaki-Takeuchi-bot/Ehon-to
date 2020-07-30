class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :name, null: false
      t.string :image
      t.string :publisher
      t.string :author_name, null: false
      t.string :author_image
      t.integer :price
      t.integer :isbn

      t.timestamps
    end
  end
end
