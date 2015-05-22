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

ActiveRecord::Schema.define(version: 20150521210609) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "categories", ["slug"], name: "index_categories_on_slug", using: :btree

  create_table "loan_request_categories", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "loan_request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loan_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.integer  "borrowing_amount",    default: 0
    t.integer  "amount_funded",       default: 0
    t.datetime "requested_by_date"
    t.datetime "payments_begin_date"
    t.datetime "payments_end_date"
    t.string   "status",              default: "open"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "blurb"
    t.string   "image_url",           default: "http://www.kiva.org/img/w632/1847429.jpg"
  end

  create_table "loans", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "loan_request_id"
    t.integer  "amount"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tenants", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "blurb"
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_roles", ["role_id"], name: "index_user_roles_on_role_id", using: :btree
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address_1"
    t.string   "address_2"
    t.integer  "zip_code"
    t.string   "state"
    t.string   "city"
    t.integer  "tenant_id"
  end

  add_index "users", ["tenant_id"], name: "index_users_on_tenant_id", using: :btree

end
