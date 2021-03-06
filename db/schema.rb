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

ActiveRecord::Schema.define(version: 20150810104248) do

  create_table "administrators", force: true do |t|
    t.string   "name",                            null: false
    t.string   "userid",                          null: false
    t.string   "password_digest",                 null: false
    t.integer  "authority_id",                    null: false
    t.string   "tel"
    t.text     "email"
    t.text     "comment"
    t.boolean  "deleted",         default: false, null: false
    t.string   "create_user"
    t.string   "edit_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "adresses", force: true do |t|
    t.integer  "user_id",                       null: false
    t.string   "postal_code_3",                 null: false
    t.string   "postal_code_4",                 null: false
    t.string   "todohuken",                     null: false
    t.string   "shikutyouson",                  null: false
    t.string   "adress_detail",                 null: false
    t.text     "comment"
    t.boolean  "deleted",       default: false, null: false
    t.string   "create_user"
    t.string   "edit_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authorities", force: true do |t|
    t.string   "name",                       null: false
    t.text     "authority",                  null: false
    t.text     "comment"
    t.boolean  "deleted",    default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cards", force: true do |t|
    t.integer  "user_id",                     null: false
    t.string   "customer_id",                 null: false
    t.text     "comment"
    t.boolean  "deleted",     default: false, null: false
    t.string   "create_user"
    t.string   "edit_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name",                        null: false
    t.integer  "gmenu_flag"
    t.text     "comment"
    t.boolean  "deleted",     default: false, null: false
    t.string   "create_user"
    t.string   "edit_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "colors", force: true do |t|
    t.string   "name",                        null: false
    t.string   "code",                        null: false
    t.text     "comment"
    t.boolean  "deleted",     default: false, null: false
    t.string   "create_user"
    t.string   "edit_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conditions", force: true do |t|
    t.string   "name",                        null: false
    t.text     "description",                 null: false
    t.text     "comment"
    t.boolean  "deleted",     default: false, null: false
    t.string   "create_user"
    t.string   "edit_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "denominations", force: true do |t|
    t.string   "name",                        null: false
    t.text     "comment"
    t.boolean  "deleted",     default: false, null: false
    t.string   "create_user"
    t.string   "edit_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fabrics", force: true do |t|
    t.string   "name",                        null: false
    t.text     "description",                 null: false
    t.text     "comment"
    t.boolean  "deleted",     default: false, null: false
    t.string   "create_user"
    t.string   "edit_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_types", force: true do |t|
    t.string   "name",                         null: false
    t.text     "unit_id_list",                 null: false
    t.text     "comment"
    t.boolean  "deleted",      default: false, null: false
    t.string   "create_user"
    t.string   "edit_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.string   "name",                            null: false
    t.integer  "subcategory_id",                  null: false
    t.integer  "price",                           null: false
    t.integer  "denomination_id",                 null: false
    t.integer  "condition_id",                    null: false
    t.string   "size",                            null: false
    t.integer  "fabric_id",                       null: false
    t.text     "description",                     null: false
    t.text     "spike_url",                       null: false
    t.text     "comment"
    t.boolean  "sold_flag",       default: false, null: false
    t.boolean  "deleted",         default: false, null: false
    t.string   "create_user"
    t.string   "edit_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "main_images", force: true do |t|
    t.binary   "image",       limit: 16777215,                 null: false
    t.integer  "item_id",                                      null: false
    t.text     "comment"
    t.boolean  "deleted",                      default: false, null: false
    t.string   "create_user"
    t.string   "edit_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "new_arrivals", force: true do |t|
    t.integer  "item_id",                     null: false
    t.text     "new_comment"
    t.text     "comment"
    t.boolean  "deleted",     default: false, null: false
    t.string   "create_user"
    t.string   "edit_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchases", force: true do |t|
    t.text     "item_id_list",                 null: false
    t.integer  "card_id",                      null: false
    t.string   "amount",                       null: false
    t.integer  "tax",                          null: false
    t.string   "shipping"
    t.integer  "status",       default: 0,     null: false
    t.boolean  "read_flg",     default: false, null: false
    t.boolean  "returne_flg",  default: false, null: false
    t.text     "comment"
    t.boolean  "deleted",      default: false, null: false
    t.string   "edit_user"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "adress_id",                    null: false
  end

  create_table "recommendation_images", force: true do |t|
    t.integer  "recommendation_id",                                  null: false
    t.binary   "image",             limit: 16777215
    t.text     "comment"
    t.boolean  "deleted",                            default: false, null: false
    t.string   "create_user"
    t.string   "edit_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recommendations", force: true do |t|
    t.integer  "item_id",                          null: false
    t.integer  "related_item_id1"
    t.integer  "related_item_id2"
    t.integer  "related_item_id3"
    t.integer  "related_item_id4"
    t.text     "recommendation"
    t.text     "comment"
    t.boolean  "deleted",          default: false, null: false
    t.string   "create_user"
    t.string   "edit_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "sizes", force: true do |t|
    t.integer  "unit_id",                      null: false
    t.integer  "item_type_id",                 null: false
    t.boolean  "deleted",      default: false, null: false
    t.string   "create_user"
    t.string   "edit_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", force: true do |t|
    t.string   "name",                        null: false
    t.integer  "ratio",                       null: false
    t.integer  "color_id",                    null: false
    t.text     "comment"
    t.boolean  "deleted",     default: false, null: false
    t.string   "create_user"
    t.string   "edit_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subcategories", force: true do |t|
    t.string   "name",                        null: false
    t.integer  "category_id",                 null: false
    t.text     "comment"
    t.boolean  "deleted",     default: false, null: false
    t.string   "create_user"
    t.string   "edit_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subimages", force: true do |t|
    t.binary   "image",       limit: 16777215,                 null: false
    t.integer  "item_id",                                      null: false
    t.text     "comment"
    t.boolean  "deleted",                      default: false, null: false
    t.string   "create_user"
    t.string   "edit_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "units", force: true do |t|
    t.string   "name",                        null: false
    t.string   "unit",                        null: false
    t.text     "comment"
    t.boolean  "deleted",     default: false, null: false
    t.string   "create_user"
    t.string   "edit_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "last_name"
    t.string   "first_name"
    t.string   "last_name_kana"
    t.string   "first_name_kana"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
