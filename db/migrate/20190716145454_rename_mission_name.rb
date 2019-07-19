class RenameMissionName < ActiveRecord::Migration[5.2]
  def change
    rename_column :missions, :name, :title
  end
end
