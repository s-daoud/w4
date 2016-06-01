class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.timestamps
      t.string :name, null: false
      t.string :email, null: false
    end
  end
end
