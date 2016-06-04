class CreateSubReddits < ActiveRecord::Migration
  def change
    create_table :sub_reddits do |t|
      t.string :title, null: false
      t.text :description
      t.integer :mod_id, null: false
      t.timestamps null: false
    end
    add_index :sub_reddits, :mod_id
  end
end
