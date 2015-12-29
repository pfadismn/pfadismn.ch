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
    t.string   "addressable_type"
    t.string   "line1"
    t.string   "line2"
    t.string   "zip"
    t.string   "place"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "relation_mask"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "organisational_unit_id"
    t.integer  "creator_id"
    t.integer  "start_place_id"
    t.integer  "end_place_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "name"
    t.text     "description"
    t.text     "take_along"
    t.text     "content"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "content_image_file_name"
    t.string   "content_image_content_type"
    t.integer  "content_image_file_size"
    t.datetime "content_image_updated_at"
  end

  add_index "events", ["creator_id"], name: "index_events_on_creator_id", using: :btree
  add_index "events", ["end_place_id"], name: "index_events_on_end_place_id", using: :btree
  add_index "events", ["organisational_unit_id"], name: "index_events_on_organisational_unit_id", using: :btree
  add_index "events", ["start_place_id"], name: "index_events_on_start_place_id", using: :btree

  create_table "meeting_protocols_members", id: false, force: :cascade do |t|
    t.integer "participant_id"
    t.integer "meeting_protocol_id"
  end

  add_index "meeting_protocols_members", ["meeting_protocol_id"], name: "index_meeting_protocols_members_on_meeting_protocol_id", using: :btree
  add_index "meeting_protocols_members", ["participant_id"], name: "index_meeting_protocols_members_on_participant_id", using: :btree

  create_table "member_contacts", id: false, force: :cascade do |t|
    t.integer "contact_id"
    t.integer "member_id"
    t.string  "relation"
  end

  create_table "member_functions", force: :cascade do |t|
    t.string  "name"
    t.string  "email"
    t.integer "mask"
  end

  create_table "members", force: :cascade do |t|
    t.integer  "organisational_unit_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "scout_name"
    t.string   "alias"
    t.string   "nationality"
    t.text     "remarks"
    t.date     "birthdate"
    t.integer  "gender"
    t.integer  "functions_mask"
    t.boolean  "vegetarian"
    t.date     "member_since"
    t.text     "education"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  add_index "members", ["organisational_unit_id"], name: "index_members_on_organisational_unit_id", using: :btree

  create_table "news", force: :cascade do |t|
    t.integer  "creator_id"
    t.string   "title"
    t.text     "body"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "publish_to_mask", default: 1
  end

  add_index "news", ["creator_id"], name: "index_news_on_creator_id", using: :btree

  create_table "organisational_units", force: :cascade do |t|
    t.string   "name"
    t.string   "motto"
    t.string   "caption"
    t.string   "responsible_function"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",               default: true
    t.string   "email"
  end

  add_index "organisational_units", ["parent_id"], name: "index_organisational_units_on_parent_id", using: :btree

  create_table "phone_numbers", force: :cascade do |t|
    t.integer  "phonable_id"
    t.string   "phonable_type"
    t.string   "phone_type"
    t.string   "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places", force: :cascade do |t|
    t.integer  "address_id"
    t.string   "name"
    t.text     "description"
    t.string   "coordinates"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "users", force: :cascade do |t|
    t.integer  "member_id"
    t.string   "email",             null: false
    t.string   "crypted_password",  null: false
    t.string   "password_salt",     null: false
    t.string   "persistence_token", null: false
    t.string   "perishable_token",  null: false
    t.integer  "roles_mask"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["persistence_token"], name: "index_users_on_persistence_token", using: :btree

end
