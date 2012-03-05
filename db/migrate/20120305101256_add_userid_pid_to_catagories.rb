class AddUseridPidToCatagories < ActiveRecord::Migration
  def change
    add_column :catagories, :user_id, :integer
    add_column :catagories, :pid, :integer
  end
end
