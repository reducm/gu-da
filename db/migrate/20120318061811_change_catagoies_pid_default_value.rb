class ChangeCatagoiesPidDefaultValue < ActiveRecord::Migration
  def up 
    change_column :catagories, :pid, :integer, :default=> '0'
  end

  def down
  end
end
