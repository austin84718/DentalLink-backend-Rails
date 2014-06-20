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

ActiveRecord::Schema.define(version: 20140620103005) do

  create_table "addresses", force: true do |t|
    t.string   "street_line_1"
    t.string   "street_line_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.string   "website"
  end

  create_table "attachments", force: true do |t|
    t.string   "filename"
    t.string   "description"
    t.integer  "patient_id"
    t.integer  "referral_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
  end

  add_index "attachments", ["patient_id"], name: "index_attachments_on_patient_id"
  add_index "attachments", ["referral_id"], name: "index_attachments_on_referral_id"

  create_table "notes", force: true do |t|
    t.text     "message"
    t.integer  "referral_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "notes", ["referral_id"], name: "index_notes_on_referral_id"
  add_index "notes", ["user_id"], name: "index_notes_on_user_id"

  create_table "patients", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "address_id"
    t.string   "email"
    t.string   "phone"
    t.date     "birthday"
    t.string   "middle_initial", limit: 1
    t.string   "salutation"
  end

  create_table "practice_invitations", force: true do |t|
    t.string   "practice_name"
    t.string   "contact_first_name"
    t.string   "contact_last_name"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.integer  "practice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "practice_invitations", ["practice_id"], name: "index_practice_invitations_on_practice_id"

  create_table "practice_types", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "practices", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.integer  "practice_type_id"
    t.string   "card_number"
    t.string   "name_on_card"
    t.integer  "card_exp_month"
    t.integer  "card_exp_year"
    t.string   "salutation"
    t.string   "account_first_name"
    t.string   "account_last_name"
    t.string   "account_middle_initial"
    t.string   "card_cvc"
    t.string   "stripe_token"
    t.string   "stripe_customer_id"
    t.string   "account_email"
  end

  add_index "practices", ["address_id"], name: "index_practices_on_address_id"
  add_index "practices", ["practice_type_id"], name: "index_practices_on_practice_type_id"

  create_table "procedures", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "practice_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "procedures", ["practice_type_id"], name: "index_procedures_on_practice_type_id"

  create_table "provider_invitations", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "token"
    t.string   "status"
    t.integer  "inviter_id"
    t.integer  "registered_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "provider_invitations", ["inviter_id"], name: "index_provider_invitations_on_inviter_id"
  add_index "provider_invitations", ["registered_user_id"], name: "index_provider_invitations_on_registered_user_id"

  create_table "referrals", force: true do |t|
    t.integer  "orig_practice_id"
    t.integer  "dest_practice_id"
    t.integer  "patient_id"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "status"
    t.string   "teeth"
    t.integer  "dest_provider_id"
    t.integer  "orig_provider_id"
    t.integer  "procedure_id"
  end

  add_index "referrals", ["dest_practice_id"], name: "index_referrals_on_dest_practice_id"
  add_index "referrals", ["dest_provider_id"], name: "index_referrals_on_dest_provider_id"
  add_index "referrals", ["orig_practice_id"], name: "index_referrals_on_orig_practice_id"
  add_index "referrals", ["orig_provider_id"], name: "index_referrals_on_orig_provider_id"
  add_index "referrals", ["patient_id"], name: "index_referrals_on_patient_id"
  add_index "referrals", ["procedure_id"], name: "index_referrals_on_procedure_id"

  create_table "users", force: true do |t|
    t.string   "title"
    t.string   "first_name"
    t.string   "middle_initial",         limit: 1
    t.string   "last_name"
    t.string   "password"
    t.integer  "practice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                            default: "", null: false
    t.string   "encrypted_password",               default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "authentication_token"
    t.integer  "roles_mask"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["practice_id"], name: "index_users_on_practice_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
