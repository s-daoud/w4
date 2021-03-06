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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160603230201) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cross_posts", force: :cascade do |t|
    t.integer  "sub_id",     null: false
    t.integer  "post_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cross_posts", ["post_id"], name: "index_cross_posts_on_post_id", using: :btree
  add_index "cross_posts", ["sub_id"], name: "index_cross_posts_on_sub_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title",      null: false
    t.string   "url"
    t.text     "content"
    t.integer  "author_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["author_id"], name: "index_posts_on_author_id", using: :btree
  add_index "posts", ["title"], name: "index_posts_on_title", unique: true, using: :btree

  create_table "sub_reddits", force: :cascade do |t|
    t.string   "title",       null: false
    t.text     "description"
    t.integer  "mod_id",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "sub_reddits", ["mod_id"], name: "index_sub_reddits_on_mod_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",        null: false
    t.string   "password_digest", null: false
    t.string   "session_token",   null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
