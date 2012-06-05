class RemoveHabitFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :habit
  end
end
