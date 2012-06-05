class RemoveBirthdayFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :birthday
  end
end
