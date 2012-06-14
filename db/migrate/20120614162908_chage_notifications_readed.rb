class ChageNotificationsReaded < ActiveRecord::Migration
  def up
    change_column :notifications, :readed, :boolean, :default => false 
  end

  def down
    change_column :notifications, :readed, :boolean, :default => true
  end
end
