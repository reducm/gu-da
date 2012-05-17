class AddUseridAndCatagoryidToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :user_id, :integer
    add_column :articles, :catagory_id, :integer, :default => 0
  end
end
