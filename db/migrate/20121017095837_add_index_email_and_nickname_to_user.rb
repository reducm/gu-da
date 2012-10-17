class AddIndexEmailAndNicknameToUser < ActiveRecord::Migration
  def change
    add_index :users, :email
    add_index :users, :nickname
  end
end
