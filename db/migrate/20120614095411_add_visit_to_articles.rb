class AddVisitToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :visit, :integer, :default => 0
  end
end
