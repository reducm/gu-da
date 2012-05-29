class RemoveHabitFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :habit
  end
end
