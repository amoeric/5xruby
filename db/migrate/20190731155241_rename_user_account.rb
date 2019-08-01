class RenameUserAccount < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :account, :email
  end
end
