class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :file
      t.string :file_name
      t.string :file_type
      t.integer :file_size
      t.string :pictureable_type
      t.string :pictureable_id

      t.timestamps
    end
  end
end
