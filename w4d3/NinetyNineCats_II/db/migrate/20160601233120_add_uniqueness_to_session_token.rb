class AddUniquenessToSessionToken < ActiveRecord::Migration
  def change
    remove_index :session_lists, :session_token
    add_index :session_lists, :session_token, unique: true
  end
end
