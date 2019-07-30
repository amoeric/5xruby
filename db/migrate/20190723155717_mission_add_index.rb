class MissionAddIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :missions, :title
    add_index :missions, :status
    add_index :missions, :end_time
  end
end
