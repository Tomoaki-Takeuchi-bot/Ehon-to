class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :name
      t.string :image
      t.string :publisher
      t.string :author_name
      t.string :author_image
      t.integer :price
      t.integer :isbn

      t.timestamps
    end
  end
end
