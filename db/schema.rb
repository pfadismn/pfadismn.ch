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

ActiveRecord::Schema.define(version: 20181106125222) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", id: :serial, force: :cascade do |t|
    t.integer "addressable_id"
    t.string "addressable_type"
    t.string "line1"
    t.string "line2"
    t.string "zip"
    t.string "place"
    t.string "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "relation_mask"
    t.text "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.integer "organisational_unit_id"
    t.integer "creator_id"
    t.integer "start_place_id"
    t.integer "end_place_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "name"
    t.text "description"
    t.text "take_along"
    t.text "content"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "content_image_file_name"
    t.string "content_image_content_type"
    t.integer "content_image_file_size"
    t.datetime "content_image_updated_at"
    t.string "start_place_description"
    t.string "end_place_description"
    t.index ["creator_id"], name: "index_events_on_creator_id"
    t.index ["end_place_id"], name: "index_events_on_end_place_id"
    t.index ["organisational_unit_id"], name: "index_events_on_organisational_unit_id"
    t.index ["start_place_id"], name: "index_events_on_start_place_id"
  end

  create_table "meeting_protocols_members", id: false, force: :cascade do |t|
    t.integer "participant_id"
    t.integer "meeting_protocol_id"
    t.index ["meeting_protocol_id"], name: "index_meeting_protocols_members_on_meeting_protocol_id"
    t.index ["participant_id"], name: "index_meeting_protocols_members_on_participant_id"
  end

  create_table "member_contacts", id: false, force: :cascade do |t|
    t.integer "contact_id"
    t.integer "member_id"
    t.string "relation"
  end

  create_table "member_functions", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "mask"
  end

  create_table "members", id: :serial, force: :cascade do |t|
    t.integer "organisational_unit_id"
    t.string "first_name"
    t.string "last_name"
    t.string "scout_name"
    t.string "alias"
    t.string "nationality"
    t.text "remarks"
    t.date "birthdate"
    t.integer "gender"
    t.integer "functions_mask"
    t.boolean "vegetarian"
    t.date "member_since"
    t.text "education"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "email"
    t.index ["organisational_unit_id"], name: "index_members_on_organisational_unit_id"
  end

  create_table "news", id: :serial, force: :cascade do |t|
    t.integer "creator_id"
    t.string "title"
    t.text "body"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "publish_to_mask", default: 1
    t.index ["creator_id"], name: "index_news_on_creator_id"
  end

  create_table "organisational_units", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "motto"
    t.string "caption"
    t.string "responsible_function"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "active", default: true
    t.string "email"
    t.index ["parent_id"], name: "index_organisational_units_on_parent_id"
  end

  create_table "phone_numbers", id: :serial, force: :cascade do |t|
    t.integer "phonable_id"
    t.string "phonable_type"
    t.string "phone_type"
    t.string "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photo_albums", force: :cascade do |t|
    t.integer "year"
    t.string "title"
    t.string "description"
    t.string "place"
    t.string "flickr_id"
    t.string "flickr_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "places", id: :serial, force: :cascade do |t|
    t.integer "address_id"
    t.string "name"
    t.text "description"
    t.string "coordinates"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", id: :serial, force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id"
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.integer "member_id"
    t.string "email", null: false
    t.string "crypted_password", null: false
    t.string "password_salt", null: false
    t.string "persistence_token", null: false
    t.string "perishable_token", null: false
    t.integer "roles_mask"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_users_on_email"
    t.index ["persistence_token"], name: "index_users_on_persistence_token"
  end

end
