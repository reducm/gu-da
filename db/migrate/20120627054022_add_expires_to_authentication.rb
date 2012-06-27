class AddExpiresToAuthentication < ActiveRecord::Migration
  def change
    add_column :authentications, :expires, :string, :default=>'0'
  end
end
