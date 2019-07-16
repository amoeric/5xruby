class AddUserIndex < ActiveRecord::Migration[5.2]
  def change
      add_index :users, :role
  end
end
