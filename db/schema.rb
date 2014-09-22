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

ActiveRecord::Schema.define(version: 20140823071502) do

  create_table "client_comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "client_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "client_comments", ["client_id"], name: "index_client_comments_on_client_id", using: :btree
  add_index "client_comments", ["user_id"], name: "index_client_comments_on_user_id", using: :btree

  create_table "client_friendships", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_one_id"
    t.integer  "client_two_id"
  end

  add_index "client_friendships", ["client_one_id"], name: "index_client_friendships_on_client_one_id", using: :btree
  add_index "client_friendships", ["client_two_id"], name: "index_client_friendships_on_client_two_id", using: :btree
  add_index "client_friendships", ["user_id"], name: "index_client_friendships_on_user_id", using: :btree

  create_table "clients", force: true do |t|
    t.integer  "production_id"
    t.string   "first_name",                null: false
    t.string   "last_name",                 null: false
    t.string   "phone_number"
    t.date     "birthdate"
    t.string   "city"
    t.integer  "gender",        default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["production_id"], name: "index_clients_on_production_id", using: :btree

  create_table "event_prices", force: true do |t|
    t.integer "event_id"
    t.integer "price"
  end

  add_index "event_prices", ["event_id"], name: "index_event_prices_on_event_id", using: :btree

  create_table "events", force: true do |t|
    t.integer  "production_id"
    t.integer  "user_id"
    t.string   "name",          null: false
    t.datetime "when",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["production_id"], name: "index_events_on_production_id", using: :btree
  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "productions", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", force: true do |t|
    t.integer  "client_id"
    t.integer  "event_id"
    t.integer  "event_price_id"
    t.integer  "promoter_id"
    t.integer  "cashier_id"
    t.boolean  "arrived",        default: false, null: false
    t.string   "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tickets", ["cashier_id"], name: "index_tickets_on_cashier_id", using: :btree
  add_index "tickets", ["client_id"], name: "index_tickets_on_client_id", using: :btree
  add_index "tickets", ["event_id"], name: "index_tickets_on_event_id", using: :btree
  add_index "tickets", ["event_price_id"], name: "index_tickets_on_event_price_id", using: :btree
  add_index "tickets", ["promoter_id"], name: "index_tickets_on_promoter_id", using: :btree

  create_table "users", force: true do |t|
    t.integer  "production_id"
    t.string   "email",                  default: "",   null: false
    t.string   "first_name",                            null: false
    t.string   "last_name",                             null: false
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role",                   default: 2,    null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean  "lock",                   default: true, null: false
    t.string   "authentication_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["production_id"], name: "index_users_on_production_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
