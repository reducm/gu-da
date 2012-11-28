class ChangePageContentToText < ActiveRecord::Migration
  def up
    change_column :pages, :content, :text
  end

  def down
    change_column :pages, :content, :string
  end
end
