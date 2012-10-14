class AddIndexToPages < ActiveRecord::Migration
  def change
    add_index :pages, :title
  end
end
