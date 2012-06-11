class ChangeUserDescription < ActiveRecord::Migration
  def up
    change_column :users, :description, :string, :limit => 142 
  end

  def down
    change_column :users, :description, :string
  end
end
