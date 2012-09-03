class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.integer :user_id, :default => 0
      t.string :uid
      t.string :nickname
      t.string :image
      t.string :asecret
      t.string :atoken

      t.timestamps
    end
  end
end
