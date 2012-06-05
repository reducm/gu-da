class ChangeArticlePreviewLength < ActiveRecord::Migration
  def up 
    change_column :articles, :preview, :string, :limit => 810 
  end

  def down
    change_column :articles, :preview, :string
  end
end
