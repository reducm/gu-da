class AddLocationToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :location, :string
  end
end
