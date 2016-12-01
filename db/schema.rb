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

ActiveRecord::Schema.define(version: 20161201213208) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["name"], name: "index_admin_users_on_name", using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "ads", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "slot"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "ads", ["slot"], name: "index_ads_on_slot", using: :btree

  create_table "blog_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "homepage_display", default: 0
    t.string   "slug"
  end

  add_index "blog_categories", ["homepage_display"], name: "index_blog_categories_on_homepage_display", using: :btree
  add_index "blog_categories", ["slug"], name: "index_blog_categories_on_slug", unique: true, using: :btree

  create_table "blog_category_posts", force: :cascade do |t|
    t.integer  "blog_category_id"
    t.integer  "post_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "blog_category_posts", ["blog_category_id"], name: "index_blog_category_posts_on_blog_category_id", using: :btree
  add_index "blog_category_posts", ["post_id"], name: "index_blog_category_posts_on_post_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "travelier_id"
    t.integer  "parent_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "categories", ["parent_id"], name: "index_categories_on_parent_id", using: :btree
  add_index "categories", ["travelier_id"], name: "index_categories_on_travelier_id", using: :btree

  create_table "contact_messages", force: :cascade do |t|
    t.string   "email"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "homepage_videos", force: :cascade do |t|
    t.string   "name"
    t.decimal  "order"
    t.boolean  "published"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
  end

  create_table "location_categories", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "location_categories", ["category_id"], name: "index_location_categories_on_category_id", using: :btree
  add_index "location_categories", ["location_id"], name: "index_location_categories_on_location_id", using: :btree

  create_table "location_species", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "species_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "location_species", ["location_id"], name: "index_location_species_on_location_id", using: :btree
  add_index "location_species", ["species_id"], name: "index_location_species_on_species_id", using: :btree

  create_table "location_weapon_types", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "weapon_type_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "location_weapon_types", ["location_id"], name: "index_location_weapon_types_on_location_id", using: :btree
  add_index "location_weapon_types", ["weapon_type_id"], name: "index_location_weapon_types_on_weapon_type_id", using: :btree

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
    t.decimal  "lat",                         precision: 10, scale: 6
    t.decimal  "long",                        precision: 10, scale: 6
    t.date     "opening_date"
    t.boolean  "featured"
    t.boolean  "follow_up"
    t.text     "description"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.integer  "handicap_status"
    t.integer  "child_status"
    t.integer  "pet_status"
    t.string   "state"
    t.integer  "status"
    t.integer  "author_id"
    t.text     "travelier_image_paths"
    t.string   "hunting_area_size"
    t.text     "terrain"
    t.text     "submitter_notes"
    t.integer  "submitter_id"
    t.string   "featured_image_file_name"
    t.string   "featured_image_content_type"
    t.integer  "featured_image_file_size"
    t.datetime "featured_image_updated_at"
    t.string   "slug"
  end

  add_index "locations", ["slug"], name: "index_locations_on_slug", unique: true, using: :btree
  add_index "locations", ["travelier_id"], name: "index_locations_on_travelier_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "body"
    t.integer  "author_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "featured_image_file_name"
    t.string   "featured_image_content_type"
    t.integer  "featured_image_file_size"
    t.datetime "featured_image_updated_at"
    t.boolean  "display_newsletter_sign_up"
    t.text     "caption"
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true, using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.string   "subtitle"
    t.string   "slug"
    t.text     "body"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "author_id"
    t.text     "external_link"
    t.string   "featured_image_file_name"
    t.string   "featured_image_content_type"
    t.integer  "featured_image_file_size"
    t.datetime "featured_image_updated_at"
    t.integer  "position"
  end

  add_index "posts", ["position"], name: "index_posts_on_position", using: :btree
  add_index "posts", ["slug"], name: "index_posts_on_slug", unique: true, using: :btree

  create_table "reviews", force: :cascade do |t|
    t.decimal  "star_rating"
    t.text     "body"
    t.integer  "submitter_id"
    t.integer  "status"
    t.integer  "location_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "reviews", ["location_id"], name: "index_reviews_on_location_id", using: :btree

  create_table "species", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "species", ["parent_id"], name: "index_species_on_parent_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                      default: "", null: false
    t.string   "encrypted_password",         default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",              default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "authentication_token"
    t.datetime "token_expires_at"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address_1"
    t.string   "city"
    t.string   "zip"
    t.string   "state"
    t.decimal  "lat"
    t.decimal  "long"
    t.string   "phone"
    t.string   "profile_image_file_name"
    t.string   "profile_image_content_type"
    t.integer  "profile_image_file_size"
    t.datetime "profile_image_updated_at"
    t.boolean  "newsletter_subscriber"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "weapon_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
