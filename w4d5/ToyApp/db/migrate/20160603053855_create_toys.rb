class CreateToys < ActiveRecord::Migration
  def change
    create_table :toys do |t|
      t.string :name, null:false
      t.integer :toyable_id
      t.string :toyable_type

      t.timestamps null: false
    end
    add_index :toys, :name, unique:true
    add_index :toys, :toyable_id
  end
end
