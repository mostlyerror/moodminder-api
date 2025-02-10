class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.string :phone_number

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :phone_number, unique: true
  end
end
