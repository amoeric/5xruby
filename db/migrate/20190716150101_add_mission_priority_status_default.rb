class AddMissionPriorityStatusDefault < ActiveRecord::Migration[5.2]
  def up
    change_column_default(:missions, :priority, 0)
    change_column_default(:missions, :status, 0)
  end
  
  def down
    change_column_default(:missions, :priority, nil)
    change_column_default(:missions, :status, nil)
  end
end
