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

ActiveRecord::Schema.define(version: 20151229130610) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer  "addressable_id"
    t.string   "addressable_type", limit: 510
    t.string   "line1",            limit: 510
    t.string   "line2",            limit: 510
    t.string   "zip",              limit: 510
    t.string   "place",            limit: 510
    t.string   "country",          limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "first_name",    limit: 510
    t.string   "last_name",     limit: 510
    t.integer  "relation_mask"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0, null: false
    t.integer  "attempts",               default: 0, null: false
    t.text     "handler",                            null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 510
    t.string   "queue",      limit: 510
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer  "organisational_unit_id"
    t.integer  "creator_id"
    t.integer  "start_place_id"
    t.integer  "end_place_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "name",                       limit: 510
    t.text     "description"
    t.text     "take_along"
    t.text     "content"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "content_image_file_name",    limit: 510
    t.string   "content_image_content_type", limit: 510
    t.integer  "content_image_file_size"
    t.datetime "content_image_updated_at"
  end

  create_table "mail_aliases", force: :cascade do |t|
    t.string   "email",      limit: 510
    t.string   "alias",      limit: 510
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "meeting_protocols_members", id: false, force: :cascade do |t|
    t.integer "participant_id"
    t.integer "meeting_protocol_id"
  end

  create_table "member_contacts", id: false, force: :cascade do |t|
    t.integer "contact_id"
    t.integer "member_id"
    t.string  "relation",   limit: 510
  end

  create_table "member_functions", force: :cascade do |t|
    t.string  "name",  limit: 510
    t.string  "email", limit: 510
    t.integer "mask"
  end

  create_table "members", force: :cascade do |t|
    t.integer  "organisational_unit_id"
    t.string   "first_name",             limit: 510
    t.string   "last_name",              limit: 510
    t.string   "scout_name",             limit: 510
    t.string   "alias",                  limit: 510
    t.string   "nationality",            limit: 510
    t.text     "remarks"
    t.date     "birthdate"
    t.integer  "gender"
    t.integer  "functions_mask"
    t.boolean  "vegetarian"
    t.date     "member_since"
    t.text     "education"
    t.string   "avatar_file_name",       limit: 510
    t.string   "avatar_content_type",    limit: 510
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  limit: 510
  end

  create_table "news", force: :cascade do |t|
    t.integer  "creator_id"
    t.string   "title",           limit: 510
    t.text     "body"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "publish_to_mask",             default: 1
  end

  create_table "organisational_units", force: :cascade do |t|
    t.string   "name",                 limit: 510
    t.string   "motto",                limit: 510
    t.string   "caption",              limit: 510
    t.string   "responsible_function", limit: 510
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active"
    t.string   "email",                limit: 510
  end

  create_table "phone_numbers", force: :cascade do |t|
    t.integer  "phonable_id"
    t.string   "phonable_type", limit: 510
    t.string   "phone_type",    limit: 510
    t.string   "number",        limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places", force: :cascade do |t|
    t.integer  "address_id"
    t.string   "name",        limit: 510
    t.text     "description"
    t.string   "coordinates", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 510, null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.integer  "member_id"
    t.string   "email",             limit: 510, null: false
    t.string   "crypted_password",  limit: 510, null: false
    t.string   "password_salt",     limit: 510, null: false
    t.string   "persistence_token", limit: 510, null: false
    t.string   "perishable_token",  limit: 510, null: false
    t.integer  "roles_mask"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
