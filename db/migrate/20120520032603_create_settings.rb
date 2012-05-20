class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :blog_name

      t.timestamps
    end
  end
end
