class ChangeUsersNameNotNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :name, false
  end
end
