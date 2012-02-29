class CreateCatagories < ActiveRecord::Migration
  def change
    create_table :catagories do |t|
      t.string :name

      t.timestamps
    end
  end
end
