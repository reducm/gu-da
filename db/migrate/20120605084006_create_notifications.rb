class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :senderable_id
      t.string :senderable_type
      t.integer :receiver_id
      t.string :content
      t.boolean :readed, :default => true

      t.timestamps
    end
  end
end
