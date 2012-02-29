class CreateAtricles < ActiveRecord::Migration
  def change
    create_table :atricles do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
