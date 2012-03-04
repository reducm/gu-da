class CreateArticleTagships < ActiveRecord::Migration
  def change
    create_table :article_tagships do |t|
      t.integer :article_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
