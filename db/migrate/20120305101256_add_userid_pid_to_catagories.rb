class AddUseridPidToCatagories < ActiveRecord::Migration
  def change
    add_column :catagories, :user_id, :pid
  end
end
