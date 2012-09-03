class AddIndex1st < ActiveRecord::Migration
  def up
    add_index :articles, :user_id
    add_index :articles, :catagory_id

    add_index :authentications, :user_id

    add_index :catagories, :user_id

    add_index :comments, :user_id
    add_index :comments, :article_id

    add_index :settings, :user_id
  end

  def down
    remove_index :articles, :column => :user_id
    remove_index :articles, :column => :catagory_id

    remove_index :authentications, :column => :user_id

    remove_index :catagories, :column => :user_id

    remove_index :comments, :column => :user_id
    remove_index :comments, :column => :article_id

    remove_index :settings, :column => :user_id

  end
end
