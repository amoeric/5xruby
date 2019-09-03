class CreateTagMissions < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_missions do |t|
      t.references :tag
      t.references :mission

      t.timestamps
    end
  end
end
