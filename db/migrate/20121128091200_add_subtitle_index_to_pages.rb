class AddSubtitleIndexToPages < ActiveRecord::Migration
  def change
    add_column :pages, :subtitle, :string
    add_index :pages, :subtitle
  end
end
