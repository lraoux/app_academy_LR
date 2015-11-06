class ChangeUsers < ActiveRecord::Migration
  def change
    remove_column :users, :name, :string
    remove_column :users, :email, :string
    add_column :users, :username, :string, unique: true
  end
end

#didn't enforce presence at DB level for username
