class AddColumnMission < ActiveRecord::Migration[5.2]
  def change
    add_column :missions, :priority, :integer
    add_column :missions, :status, :integer
    add_column :missions, :start_time, :datetime
    add_column :missions, :end_time, :datetime
  end
end
