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

ActiveRecord::Schema.define(version: 20140807151312) do

  create_table "accounts", force: true do |t|
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "jp_user"
    t.string   "jp_pass"
    t.string   "jp_email"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id"

  create_table "commodities", force: true do |t|
    t.string   "name"
    t.string   "commodity_type"
    t.string   "units"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "account_id"
  end

  add_index "commodities", ["account_id"], name: "index_commodities_on_account_id"
  add_index "commodities", ["user_id"], name: "index_commodities_on_user_id"

  create_table "delayed_jobs", force: true do |t|
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

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "deliveries", force: true do |t|
    t.integer  "commodity_id"
    t.integer  "farmer_id"
    t.integer  "quantity"
    t.float    "price"
    t.float    "total"
    t.boolean  "paid_for"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "account_id"
  end

  add_index "deliveries", ["account_id"], name: "index_deliveries_on_account_id"
  add_index "deliveries", ["commodity_id"], name: "index_deliveries_on_commodity_id"
  add_index "deliveries", ["farmer_id"], name: "index_deliveries_on_farmer_id"
  add_index "deliveries", ["user_id"], name: "index_deliveries_on_user_id"

  create_table "farmers", force: true do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "location"
    t.string   "registration_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "account_id"
    t.string   "slug"
  end

  add_index "farmers", ["account_id"], name: "index_farmers_on_account_id"
  add_index "farmers", ["slug"], name: "index_farmers_on_slug", unique: true
  add_index "farmers", ["user_id"], name: "index_farmers_on_user_id"

  create_table "payments", force: true do |t|
    t.float    "amount"
    t.integer  "farmer_id"
    t.integer  "delivery_id"
    t.integer  "user_id"
    t.string   "transaction_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.string   "trace"
    t.string   "status"
  end

  add_index "payments", ["account_id"], name: "index_payments_on_account_id"
  add_index "payments", ["delivery_id"], name: "index_payments_on_delivery_id"
  add_index "payments", ["farmer_id"], name: "index_payments_on_farmer_id"
  add_index "payments", ["user_id"], name: "index_payments_on_user_id"

  create_table "prices", force: true do |t|
    t.integer  "commodity_id"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "account_id"
  end

  add_index "prices", ["account_id"], name: "index_prices_on_account_id"
  add_index "prices", ["commodity_id"], name: "index_prices_on_commodity_id"
  add_index "prices", ["user_id"], name: "index_prices_on_user_id"

  create_table "user_accounts", force: true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_accounts", ["account_id"], name: "index_user_accounts_on_account_id"
  add_index "user_accounts", ["user_id"], name: "index_user_accounts_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                    default: "", null: false
    t.string   "encrypted_password",       default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",        default: 0
    t.string   "profile_pic_file_name"
    t.string   "profile_pic_content_type"
    t.integer  "profile_pic_file_size"
    t.datetime "profile_pic_updated_at"
    t.boolean  "is_admin"
    t.integer  "account_id"
  end

  add_index "users", ["account_id"], name: "index_users_on_account_id"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count"
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
