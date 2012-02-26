class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :salt
      t.date :birthday
      t.string :head
      t.string :description
      t.string :habit

      t.timestamps
    end
  end
end
