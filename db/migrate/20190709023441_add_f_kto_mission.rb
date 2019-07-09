class AddFKtoMission < ActiveRecord::Migration[5.2]
  def change
    add_reference :missions, :user
  end
end
