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

ActiveRecord::Schema.define(version: 20131031021036) do

  create_table "addresses", force: true do |t|
    t.string   "street_line_1"
    t.string   "street_line_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patients", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "practices", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "practices", ["address_id"], name: "index_practices_on_address_id"

  create_table "referrals", force: true do |t|
    t.integer  "orig_practice_id"
    t.integer  "dest_practice_id"
    t.integer  "patient_id"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "referrals", ["dest_practice_id"], name: "index_referrals_on_dest_practice_id"
  add_index "referrals", ["orig_practice_id"], name: "index_referrals_on_orig_practice_id"
  add_index "referrals", ["patient_id"], name: "index_referrals_on_patient_id"

  create_table "users", force: true do |t|
    t.string   "group"
    t.string   "title"
    t.string   "first_name"
    t.string   "middle_initial", limit: 1
    t.string   "last_name"
    t.string   "username"
    t.string   "password"
    t.integer  "practice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["practice_id"], name: "index_users_on_practice_id"

end
