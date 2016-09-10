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

ActiveRecord::Schema.define(version: 20160910042515) do

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.integer  "commenter_id",     limit: 4
    t.text     "body",             limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
  add_index "comments", ["commenter_id"], name: "index_comments_on_commenter_id", using: :btree

  create_table "followings", force: :cascade do |t|
    t.integer  "followee_id",   limit: 4
    t.string   "followee_type", limit: 255
    t.integer  "follower_id",   limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "followings", ["followee_id", "followee_type", "follower_id"], name: "followee_and_follower", unique: true, using: :btree
  add_index "followings", ["followee_type", "followee_id"], name: "index_followings_on_followee_type_and_followee_id", using: :btree
  add_index "followings", ["follower_id"], name: "index_followings_on_follower_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.text     "body",           limit: 65535
    t.integer  "author_id",      limit: 4
    t.integer  "stockers_count", limit: 4,     default: 0, null: false
    t.integer  "comments_count", limit: 4,     default: 0, null: false
    t.string   "scope",          limit: 255,               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
  end

  add_index "items", ["author_id"], name: "index_items_on_author_id", using: :btree

  create_table "stocks", force: :cascade do |t|
    t.integer  "stockable_id",   limit: 4
    t.string   "stockable_type", limit: 255
    t.integer  "stocker_id",     limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "stocks", ["stockable_id", "stockable_type", "stocker_id"], name: "index_stocks_on_stockable_id_and_stockable_type_and_stocker_id", unique: true, using: :btree
  add_index "stocks", ["stockable_type", "stockable_id"], name: "index_stocks_on_stockable_type_and_stockable_id", using: :btree
  add_index "stocks", ["stocker_id"], name: "index_stocks_on_stocker_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tag_id",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "tag_id"], name: "index_taggings_on_taggable_id_and_taggable_type_and_tag_id", unique: true, using: :btree
  add_index "taggings", ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",            limit: 255,             null: false
    t.integer  "taggables_count", limit: 4,   default: 0, null: false
    t.integer  "followers_count", limit: 4,   default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.integer  "followers_count",        limit: 4,   default: 0,  null: false
    t.integer  "stocked_items_count",    limit: 4,   default: 0,  null: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "username",               limit: 255
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "icon_url",               limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
