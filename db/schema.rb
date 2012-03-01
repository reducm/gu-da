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

<<<<<<< HEAD
ActiveRecord::Schema.define(:version => 20120301112830) do

  create_table "articles", :force => true do |t|
=======
ActiveRecord::Schema.define(:version => 20120229113820) do

  create_table "atricles", :force => true do |t|
>>>>>>> 8d7f068c135b4bce102796ecfa97fffc441cebfb
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
<<<<<<< HEAD
    t.integer  "user_id"
    t.integer  "catagory_id"
=======
>>>>>>> 8d7f068c135b4bce102796ecfa97fffc441cebfb
  end

  create_table "catagories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.string   "salt"
    t.date     "birthday"
    t.string   "head"
    t.string   "description"
    t.string   "habit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
