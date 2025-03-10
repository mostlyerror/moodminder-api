class CreateMoodOptions < ActiveRecord::Migration[7.2]
  def change
    create_table :mood_options do |t|
      t.string :emoji
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
