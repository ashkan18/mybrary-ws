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

ActiveRecord::Schema.define(version: 20150929204252) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.string   "access_token"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "api_keys", ["user_id"], name: "index_api_keys_on_user_id", using: :btree

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "book_genres", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "book_genres", ["book_id"], name: "index_book_genres_on_book_id", using: :btree
  add_index "book_genres", ["genre_id"], name: "index_book_genres_on_genre_id", using: :btree

  create_table "book_instances", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.decimal  "lat"
    t.decimal  "lon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "offer_type"
  end

  add_index "book_instances", ["book_id"], name: "index_book_instances_on_book_id", using: :btree
  add_index "book_instances", ["user_id"], name: "index_book_instances_on_user_id", using: :btree

  create_table "book_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_instance_id"
    t.integer  "trans_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.float    "trans_value"
    t.integer  "status"
  end

  add_index "book_requests", ["book_instance_id"], name: "index_book_requests_on_book_instance_id", using: :btree
  add_index "book_requests", ["user_id"], name: "index_book_requests_on_user_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "name"
    t.integer  "author_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "isbn"
    t.string   "small_cover_url"
    t.string   "small_medium_url"
    t.string   "small_large_url"
  end

  add_index "books", ["author_id"], name: "index_books_on_author_id", using: :btree

  create_table "genres", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "account_type"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "api_keys", "users"
  add_foreign_key "book_genres", "books"
  add_foreign_key "book_genres", "genres"
  add_foreign_key "book_instances", "books"
  add_foreign_key "book_instances", "users"
  add_foreign_key "book_requests", "book_instances"
  add_foreign_key "book_requests", "users"
  add_foreign_key "books", "authors"
end
