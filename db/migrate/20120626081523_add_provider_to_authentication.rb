class AddProviderToAuthentication < ActiveRecord::Migration
  def change
    add_column :authentications, :provider, :string
  end
end
