class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name, null: false
    end
  end
end
