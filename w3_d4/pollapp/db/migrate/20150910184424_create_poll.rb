class CreatePoll < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :title
      t.integer :user_id, null: false
      t.timestamps
    end

    add_foreign_key :polls, :users
    add_index :polls, :user_id
    add_index :users, :user_name, unique: true
  end
end
