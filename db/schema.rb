# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120919095602) do

  create_table "article_tagships", :force => true do |t|
    t.integer  "article_id"
    t.integer  "tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "user_id"
    t.integer  "catagory_id",                :default => 0
    t.string   "preview",     :limit => 810
    t.integer  "visit",                      :default => 0
  end

  add_index "articles", ["catagory_id"], :name => "index_articles_on_catagory_id"
  add_index "articles", ["user_id"], :name => "index_articles_on_user_id"

  create_table "authentications", :force => true do |t|
    t.integer  "user_id",    :default => 0
    t.string   "uid"
    t.string   "nickname"
    t.string   "image"
    t.string   "asecret"
    t.string   "atoken"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "provider"
    t.string   "expires",    :default => "0"
    t.string   "location"
  end

  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "catagories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "user_id"
    t.integer  "pid",        :default => 0
  end

  add_index "catagories", ["user_id"], :name => "index_catagories_on_user_id"

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "user_id",       :default => 0
    t.integer  "article_id"
    t.string   "visitor_name"
    t.string   "visitor_email"
  end

  add_index "comments", ["article_id"], :name => "index_comments_on_article_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "notifications", :force => true do |t|
    t.integer  "senderable_id"
    t.string   "senderable_type"
    t.integer  "receiver_id"
    t.string   "content"
    t.boolean  "readed",          :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pictures", :force => true do |t|
    t.string   "file"
    t.string   "file_name"
    t.string   "file_type"
    t.integer  "file_size"
    t.string   "pictureable_type"
    t.string   "pictureable_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "settings", :force => true do |t|
    t.string   "blog_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  add_index "settings", ["user_id"], :name => "index_settings_on_user_id"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_tagships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "nickname"
    t.string   "email"
    t.string   "password"
    t.string   "salt"
    t.string   "description", :limit => 142
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

end
