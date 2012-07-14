class ChangeUserNameTonickname < ActiveRecord::Migration
  def up
    rename_column :users, :name, :nickname
  end

  def down
    rename_column :users, :nickname, :name
  end
end
