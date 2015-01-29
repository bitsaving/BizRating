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

ActiveRecord::Schema.define(version: 20150129135755) do

  create_table "addresses", force: :cascade do |t|
    t.string   "street",      limit: 255
    t.string   "building",    limit: 255
    t.string   "landmark",    limit: 255
    t.string   "area",        limit: 255
    t.string   "city",        limit: 255
    t.string   "pin_code",    limit: 255
    t.string   "country",     limit: 255
    t.string   "state",       limit: 255
    t.integer  "business_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "businesses", force: :cascade do |t|
    t.string   "name",                  limit: 255,                  null: false
    t.string   "owner_name",            limit: 255
    t.text     "description",           limit: 65535
    t.string   "year_of_establishment", limit: 255
    t.integer  "category_id",           limit: 4
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "status",                limit: 1,     default: true, null: false
  end

  create_table "businesses_keywords", id: false, force: :cascade do |t|
    t.integer "business_id", limit: 4, null: false
    t.integer "keyword_id",  limit: 4, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.boolean  "status",             limit: 1,   default: true, null: false
    t.integer  "position",           limit: 4,                  null: false
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string  "details",     limit: 255
    t.string  "type",        limit: 255
    t.integer "business_id", limit: 4
  end

  create_table "images", force: :cascade do |t|
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.integer  "business_id",        limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "keywords", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4, null: false
    t.integer "role_id", limit: 4, null: false
  end

  add_index "roles_users", ["user_id", "role_id"], name: "index_roles_users_on_user_id_and_role_id", using: :btree

  create_table "time_slots", force: :cascade do |t|
    t.time    "from",                      null: false
    t.time    "to",                        null: false
    t.text    "days",        limit: 65535, null: false
    t.integer "business_id", limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255,             null: false
    t.string   "email",                  limit: 255,             null: false
    t.string   "encrypted_password",     limit: 255,             null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
