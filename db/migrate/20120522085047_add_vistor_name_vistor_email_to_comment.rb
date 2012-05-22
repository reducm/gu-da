class AddVistorNameVistorEmailToComment < ActiveRecord::Migration
  def change
    add_column :comments, :vistor_name, :string
    add_column :comments, :vistor_email, :string
  end
end
