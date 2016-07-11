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

ActiveRecord::Schema.define(version: 20160709154250) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.string   "user_answer"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree

  create_table "contracted_pharmacies", force: :cascade do |t|
    t.integer  "hcf_pharmacy_id"
    t.integer  "user_id"
    t.integer  "health_care_facility_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "contracted_pharmacies", ["hcf_pharmacy_id"], name: "index_contracted_pharmacies_on_hcf_pharmacy_id", using: :btree
  add_index "contracted_pharmacies", ["health_care_facility_id", "hcf_pharmacy_id"], name: "unique_contracted_pharmacies", unique: true, using: :btree
  add_index "contracted_pharmacies", ["health_care_facility_id"], name: "index_contracted_pharmacies_on_health_care_facility_id", using: :btree
  add_index "contracted_pharmacies", ["user_id"], name: "index_contracted_pharmacies_on_user_id", using: :btree

  create_table "dni_pharmacies", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "latitude"
    t.string   "longitude"
    t.integer  "match_score"
    t.integer  "user_id"
    t.string   "surescripts_id"
    t.string   "stateList_id"
    t.string   "npi"
    t.string   "short_code"
    t.string   "image_url"
    t.boolean  "active",         default: false, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "dni_pharmacies", ["short_code"], name: "index_dni_pharmacies_on_short_code", using: :btree
  add_index "dni_pharmacies", ["user_id"], name: "index_dni_pharmacies_on_user_id", using: :btree

  create_table "drug_prices", force: :cascade do |t|
    t.float    "days_supply"
    t.float    "quantity"
    t.string   "generic_id"
    t.string   "ndc11"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drugs", force: :cascade do |t|
    t.string   "ndc11"
    t.string   "name"
    t.string   "name_prefix"
    t.string   "generic_id"
    t.string   "therapy_class_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hcf_locations", force: :cascade do |t|
    t.string   "address"
    t.string   "phone"
    t.string   "name"
    t.string   "email"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "image_url"
    t.integer  "user_id"
    t.integer  "health_care_facility_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "image_url_file_name"
    t.string   "image_url_content_type"
    t.integer  "image_url_file_size"
    t.datetime "image_url_updated_at"
  end

  add_index "hcf_locations", ["health_care_facility_id"], name: "index_hcf_locations_on_health_care_facility_id", using: :btree
  add_index "hcf_locations", ["user_id"], name: "index_hcf_locations_on_user_id", using: :btree

  create_table "hcf_pharmacies", force: :cascade do |t|
    t.string   "external_id"
    t.integer  "health_care_facility_id"
    t.integer  "dni_pharmacy_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "hcf_pharmacies", ["dni_pharmacy_id"], name: "index_hcf_pharmacies_on_dni_pharmacy_id", using: :btree
  add_index "hcf_pharmacies", ["health_care_facility_id", "dni_pharmacy_id"], name: "unique_dni_pharmacies", unique: true, using: :btree
  add_index "hcf_pharmacies", ["health_care_facility_id"], name: "index_hcf_pharmacies_on_health_care_facility_id", using: :btree

  create_table "hcf_rewards", force: :cascade do |t|
    t.integer  "reward_id"
    t.integer  "health_care_facility_id"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "hcf_rewards", ["health_care_facility_id"], name: "index_hcf_rewards_on_health_care_facility_id", using: :btree
  add_index "hcf_rewards", ["reward_id"], name: "index_hcf_rewards_on_reward_id", using: :btree
  add_index "hcf_rewards", ["user_id"], name: "index_hcf_rewards_on_user_id", using: :btree

  create_table "health_care_facilities", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "image_url"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "image_url_file_name"
    t.string   "image_url_content_type"
    t.integer  "image_url_file_size"
    t.datetime "image_url_updated_at"
  end

  add_index "health_care_facilities", ["user_id"], name: "index_health_care_facilities_on_user_id", using: :btree

  create_table "pharmacies", force: :cascade do |t|
    t.float    "distance_miles_max"
    t.string   "distance_from_zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pharmacy_edit_requests", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "surescripts_id"
    t.string   "stateList_id"
    t.integer  "dni_pharmacy_id"
    t.boolean  "approved",        default: false, null: false
    t.boolean  "denied",          default: false, null: false
    t.integer  "user_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "pharmacy_edit_requests", ["dni_pharmacy_id"], name: "index_pharmacy_edit_requests_on_dni_pharmacy_id", using: :btree
  add_index "pharmacy_edit_requests", ["user_id"], name: "index_pharmacy_edit_requests_on_user_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "value"
    t.integer  "survey_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "questions", ["survey_id"], name: "index_questions_on_survey_id", using: :btree

  create_table "rewards", force: :cascade do |t|
    t.string   "name"
    t.string   "reward_type"
    t.integer  "cost"
    t.string   "description"
    t.binary   "image_url"
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "image_url_file_name"
    t.string   "image_url_content_type"
    t.integer  "image_url_file_size"
    t.datetime "image_url_updated_at"
  end

  add_index "rewards", ["user_id"], name: "index_rewards_on_user_id", using: :btree

  create_table "surveys", force: :cascade do |t|
    t.string   "survery_type"
    t.integer  "health_care_facility_id"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "surveys", ["health_care_facility_id"], name: "index_surveys_on_health_care_facility_id", using: :btree
  add_index "surveys", ["user_id"], name: "index_surveys_on_user_id", using: :btree

  create_table "user_rewards", force: :cascade do |t|
    t.integer  "hcf_reward_id"
    t.integer  "user_id"
    t.boolean  "redeemed"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "user_rewards", ["hcf_reward_id"], name: "index_user_rewards_on_hcf_reward_id", using: :btree
  add_index "user_rewards", ["user_id"], name: "index_user_rewards_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider",                default: "email", null: false
    t.string   "uid",                     default: "",      null: false
    t.string   "encrypted_password",      default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image_url"
    t.string   "email"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.integer  "role"
    t.json     "tokens"
    t.integer  "api_rpm"
    t.string   "api_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "health_care_facility_id"
    t.integer  "invited_by_id"
    t.string   "image_url_file_name"
    t.string   "image_url_content_type"
    t.integer  "image_url_file_size"
    t.datetime "image_url_updated_at"
  end

  add_index "users", ["api_token"], name: "index_users_on_api_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["health_care_facility_id"], name: "index_users_on_health_care_facility_id", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  add_foreign_key "answers", "questions"
  add_foreign_key "contracted_pharmacies", "hcf_pharmacies"
  add_foreign_key "contracted_pharmacies", "health_care_facilities"
  add_foreign_key "contracted_pharmacies", "users"
  add_foreign_key "dni_pharmacies", "users"
  add_foreign_key "hcf_locations", "health_care_facilities"
  add_foreign_key "hcf_locations", "users"
  add_foreign_key "hcf_pharmacies", "dni_pharmacies"
  add_foreign_key "hcf_pharmacies", "health_care_facilities"
  add_foreign_key "hcf_rewards", "health_care_facilities"
  add_foreign_key "hcf_rewards", "rewards"
  add_foreign_key "hcf_rewards", "users"
  add_foreign_key "health_care_facilities", "users"
  add_foreign_key "pharmacy_edit_requests", "dni_pharmacies"
  add_foreign_key "pharmacy_edit_requests", "users"
  add_foreign_key "questions", "surveys"
  add_foreign_key "rewards", "users"
  add_foreign_key "surveys", "health_care_facilities"
  add_foreign_key "surveys", "users"
  add_foreign_key "user_rewards", "hcf_rewards"
  add_foreign_key "user_rewards", "users"
  add_foreign_key "users", "health_care_facilities"
  add_foreign_key "users", "users", column: "invited_by_id"
end
