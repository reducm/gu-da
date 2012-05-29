class RemoveHeadFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :head
  end
end
