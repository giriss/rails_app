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

ActiveRecord::Schema.define(version: 20140515213146) do

  create_table "advert_details", force: true do |t|
    t.integer  "advert_id"
    t.string   "ad_title"
    t.string   "description"
    t.string   "images"
    t.string   "video"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "website"
  end

  create_table "adverts", force: true do |t|
    t.string   "name"
    t.integer  "type"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "question"
    t.string   "right_option"
    t.string   "wrong_option1"
    t.string   "wrong_option2"
    t.string   "wrong_option3"
    t.string   "wrong_option4"
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

  create_table "images", force: true do |t|
    t.integer  "user_id"
    t.string   "extension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "preview_advert_details", force: true do |t|
    t.integer  "advert_id"
    t.string   "ad_title"
    t.string   "description"
    t.string   "images"
    t.string   "video"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "website"
  end

  create_table "preview_images", force: true do |t|
    t.integer  "user_id"
    t.string   "extension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skip_ad_details", force: true do |t|
    t.string   "token"
    t.string   "url_key"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "attempt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "campaign_id"
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
    t.string   "api_key"
  end

end
