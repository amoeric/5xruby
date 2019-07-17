class CreateTagMissions < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_missions do |t|
      t.references :tag, foreign_key: true
      t.references :mission, foreign_key: true

      t.timestamps
    end
  end
end
