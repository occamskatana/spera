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

ActiveRecord::Schema.define(version: 20160311012445) do

  create_table "aboutmes", force: :cascade do |t|
    t.integer  "user_id"
    t.date     "sober_date"
    t.string   "tagline"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "private"
    t.text     "description"
  end

  add_index "aboutmes", ["user_id"], name: "index_aboutmes_on_user_id"

  create_table "boards", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.float    "rank"
  end

  add_index "boards", ["user_id"], name: "index_boards_on_user_id"

  create_table "checkins", force: :cascade do |t|
    t.boolean  "sober"
    t.integer  "mood"
    t.text     "remarks"
    t.boolean  "need_support"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "checkins", ["user_id"], name: "index_checkins_on_user_id"

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "friendables", force: :cascade do |t|
    t.integer  "from_id"
    t.integer  "to_id"
    t.boolean  "accepted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "goals", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "to_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "viewed"
  end

  add_index "notifications", ["event_id"], name: "index_notifications_on_event_id"

  create_table "objectives", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "goal_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.date     "date"
    t.text     "description"
    t.boolean  "completed"
    t.integer  "length"
    t.string   "title"
  end

  add_index "objectives", ["goal_id"], name: "index_objectives_on_goal_id"
  add_index "objectives", ["user_id"], name: "index_objectives_on_user_id"

  create_table "occurrences", force: :cascade do |t|
    t.integer  "objective_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.date     "date"
    t.boolean  "completed"
  end

  add_index "occurrences", ["objective_id"], name: "index_occurrences_on_objective_id"
  add_index "occurrences", ["user_id"], name: "index_occurrences_on_user_id"

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "board_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["board_id"], name: "index_posts_on_board_id"
  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.boolean  "private"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "votes", force: :cascade do |t|
    t.integer "value"
    t.integer "user_id"
    t.integer "board_id"
  end

  add_index "votes", ["board_id"], name: "index_votes_on_board_id"
  add_index "votes", ["user_id"], name: "index_votes_on_user_id"

end
