class AddMissingColumnsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :timezone, :string
    add_column :users, :active, :boolean
  end
end
