class RemoveHeadFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :head
  end
end
