class CreateCrossPosts < ActiveRecord::Migration
  def change
    create_table :cross_posts do |t|
      t.integer :sub_id, null: false
      t.integer :post_id, null: false

      t.timestamps null: false
    end
    add_index :cross_posts, :sub_id
    add_index :cross_posts, :post_id
  end
end
