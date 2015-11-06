class CreateQuestion < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :text, null: false
      t.integer :poll_id, null: false

    end
    add_index :questions, :poll_id
  end
end
