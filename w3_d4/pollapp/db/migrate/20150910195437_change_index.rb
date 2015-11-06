class ChangeIndex < ActiveRecord::Migration
  def change
    remove_index :responses, :user_id
    add_index :responses, :user_id
  end
end
