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

ActiveRecord::Schema.define(:version => 20120605084006) do

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
  end

  create_table "catagories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "user_id"
    t.integer  "pid",        :default => 0
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "user_id",      :default => 0
    t.integer  "article_id"
    t.string   "vistor_name"
    t.string   "vistor_email"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "senderable_id"
    t.string   "senderable_type"
    t.integer  "receiver_id"
    t.string   "content"
    t.boolean  "readed",          :default => true
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
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
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.string   "salt"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
