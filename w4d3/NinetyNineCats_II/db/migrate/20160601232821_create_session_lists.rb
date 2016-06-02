class CreateSessionLists < ActiveRecord::Migration
  def change
    create_table :session_lists do |t|
      t.integer :user_id, null: false
      t.string :session_token, null: false

      t.timestamps
    end
    add_index :session_lists, :user_id
    add_index :session_lists, :session_token
  end
end
