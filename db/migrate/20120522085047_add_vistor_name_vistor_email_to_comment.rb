class AddVistorNameVistorEmailToComment < ActiveRecord::Migration
  def change
    add_column :comments, :visitor_name, :string
    add_column :comments, :visitor_email, :string
  end
end
