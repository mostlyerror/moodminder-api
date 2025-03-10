class CreateMoodEntries < ActiveRecord::Migration[7.2]
  def change
    create_table :mood_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.string :mood_options
      t.datetime :timestamp

      t.timestamps
    end
  end
end
