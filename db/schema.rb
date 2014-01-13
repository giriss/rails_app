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

ActiveRecord::Schema.define(version: 20131230094220) do

  create_table "adverts", force: true do |t|
    t.string   "name"
    t.integer  "type"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "announcements", force: true do |t|
    t.string   "title"
    t.string   "body"
    t.string   "for"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deposits", force: true do |t|
    t.integer  "user_id"
    t.float    "amount"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "received_amount"
    t.string   "token"
  end

  create_table "error_logs", force: true do |t|
    t.integer  "user_id"
    t.string   "detail"
    t.string   "controller_action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "urls", force: true do |t|
    t.integer  "user_id"
    t.string   "key"
    t.string   "target"
    t.integer  "views"
    t.integer  "unique_views"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_other_details", force: true do |t|
    t.integer  "user_id"
    t.string   "tracker_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "full_name"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
