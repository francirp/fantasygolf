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

ActiveRecord::Schema.define(version: 20150126040948) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "active_admin_comments", force: true do |t|
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

  create_table "admin_users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "competitors", force: true do |t|
    t.integer  "golfer_id"
    t.integer  "tournament_id"
    t.string   "rank"
    t.float    "earnings"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "scores"
    t.integer  "rank_num"
  end

  create_table "courses", force: true do |t|
    t.string   "sports_data_api_id"
    t.string   "name"
    t.integer  "yardage"
    t.integer  "par"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "venue_id"
  end

  create_table "golfers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sports_data_api_id"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "height"
    t.integer  "weight"
    t.date     "birthday"
    t.string   "country"
    t.string   "residence"
    t.string   "birth_place"
    t.boolean  "member"
    t.date     "updated"
    t.string   "college"
    t.integer  "turned_pro"
    t.integer  "seed"
    t.string   "ball_maker"
    t.string   "club_maker"
    t.float    "drive_avg"
    t.integer  "cuts_made"
    t.integer  "cuts"
    t.float    "drive_acc"
    t.integer  "earnings_rank"
    t.integer  "events_played"
    t.integer  "points_rank"
    t.integer  "points"
    t.integer  "first_place"
    t.float    "gir_pct"
    t.float    "hole_proximity_avg"
    t.float    "scoring_avg"
    t.float    "scrambling_pct"
    t.float    "earnings"
    t.integer  "second_place"
    t.float    "strokes_gained"
    t.integer  "third_place"
    t.integer  "top_10"
    t.integer  "top_25"
    t.integer  "withdrawals"
    t.integer  "world_rank"
  end

  create_table "holes", force: true do |t|
    t.integer  "course_id"
    t.integer  "number"
    t.integer  "par"
    t.integer  "yardage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "holes", ["course_id"], name: "index_holes_on_course_id", using: :btree

  create_table "leagues", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
    t.integer  "user_id"
    t.integer  "league_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  create_table "tournaments", force: true do |t|
    t.string   "name"
    t.date     "start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sports_data_api_id"
    t.string   "event_type"
    t.float    "purse"
    t.float    "winning_share"
    t.date     "end_date"
    t.integer  "venue_id"
    t.integer  "year"
    t.float    "points"
    t.string   "status"
    t.string   "coverage"
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", force: true do |t|
    t.string   "sports_data_api_id"
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
