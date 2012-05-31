class ChangeArticlePreviewLength < ActiveRecord::Migration
  def change
    change_column :articles, :preview, :string, :limit => 410 
  end
end
