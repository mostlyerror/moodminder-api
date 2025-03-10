class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content
      t.string :direction
      t.string :status
      t.json :metadata
      t.datetime :sent_at

      t.timestamps
    end
  end
end
