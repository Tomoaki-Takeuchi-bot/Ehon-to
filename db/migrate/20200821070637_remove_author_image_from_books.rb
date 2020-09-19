class RemoveAuthorImageFromBooks < ActiveRecord::Migration[6.0]
  def change
    remove_column :books, :author_image, :string
  end
end
