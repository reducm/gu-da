class AddBlogNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :blog_name, :string
  end
end
