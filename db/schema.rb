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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120118191214) do

  create_table "addresses", :force => true do |t|
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

  create_table "contacts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "relation_mask"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
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
  end

  add_index "events", ["creator_id"], :name => "index_events_on_creator_id"
  add_index "events", ["end_place_id"], :name => "index_events_on_end_place_id"
  add_index "events", ["organisational_unit_id"], :name => "index_events_on_organisational_unit_id"
  add_index "events", ["start_place_id"], :name => "index_events_on_start_place_id"

  create_table "meeting_protocols", :force => true do |t|
    t.integer  "organisational_unit_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "meeting_protocols", ["organisational_unit_id"], :name => "index_meeting_protocols_on_organisational_unit_id"

  create_table "meeting_protocols_members", :id => false, :force => true do |t|
    t.integer "participant_id"
    t.integer "meeting_protocol_id"
  end

  add_index "meeting_protocols_members", ["meeting_protocol_id"], :name => "index_meeting_protocols_members_on_meeting_protocol_id"
  add_index "meeting_protocols_members", ["participant_id"], :name => "index_meeting_protocols_members_on_participant_id"

  create_table "member_contacts", :id => false, :force => true do |t|
    t.integer "contact_id"
    t.integer "member_id"
    t.string  "relation"
  end

  create_table "members", :force => true do |t|
    t.integer  "organisational_unit_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "scout_name"
    t.string   "email"
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
  end

  add_index "members", ["organisational_unit_id"], :name => "index_members_on_organisational_unit_id"

  create_table "news", :force => true do |t|
    t.integer  "creator_id"
    t.string   "title"
    t.text     "body"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "news", ["creator_id"], :name => "index_news_on_creator_id"

  create_table "organisational_units", :force => true do |t|
    t.string   "name"
    t.string   "motto"
    t.string   "caption"
    t.string   "responsible_function"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organisational_units", ["parent_id"], :name => "index_organisational_units_on_parent_id"

  create_table "phone_numbers", :force => true do |t|
    t.integer  "phonable_id"
    t.string   "phonable_type"
    t.string   "phone_type"
    t.string   "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places", :force => true do |t|
    t.integer  "address_id"
    t.string   "name"
    t.text     "description"
    t.string   "coordinates"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.integer  "member_id"
    t.string   "email",             :null => false
    t.string   "crypted_password",  :null => false
    t.string   "password_salt",     :null => false
    t.string   "persistence_token", :null => false
    t.string   "perishable_token",  :null => false
    t.integer  "roles_mask"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
