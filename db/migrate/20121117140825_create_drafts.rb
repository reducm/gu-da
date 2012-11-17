class CreateDrafts < ActiveRecord::Migration
  def change
    create_table :drafts do |t|
      t.string :title
      t.text :content
      t.boolean :manual
      t.integer :user_id

      t.timestamps
    end

    add_index :drafts, :user_id 
  end
end
