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

ActiveRecord::Schema.define(version: 20160630135109) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.integer  "travelier_id"
    t.string   "name"
    t.text     "website"
    t.text     "contact_page"
    t.string   "phone"
    t.string   "email"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "zip"
    t.decimal  "lat",             precision: 10, scale: 6
    t.decimal  "long",            precision: 10, scale: 6
    t.date     "opening_date"
    t.boolean  "featured"
    t.boolean  "follow_up"
    t.text     "description"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "handicap_status"
    t.integer  "child_status"
    t.integer  "pet_status"
    t.string   "state"
  end
  create_table "users", force: :cascade do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "authentication_token"
    t.datetime "token_expires_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
