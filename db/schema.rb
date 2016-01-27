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

ActiveRecord::Schema.define(version: 20160127074427) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "role_members", force: :cascade do |t|
    t.integer  "role_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id", "user_id"], name: "index_role_members_on_role_id_and_user_id", unique: true, using: :btree
    t.index ["role_id"], name: "index_role_members_on_role_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedule_roles", force: :cascade do |t|
    t.integer  "schedule_id"
    t.integer  "role_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["schedule_id"], name: "index_schedule_roles_on_schedule_id", using: :btree
  end

  create_table "schedule_users", force: :cascade do |t|
    t.integer  "schedule_id"
    t.integer  "user_id"
    t.integer  "status"
    t.text     "note"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["schedule_id"], name: "index_schedule_users_on_schedule_id", using: :btree
  end

  create_table "schedules", force: :cascade do |t|
    t.string   "title",                 null: false
    t.datetime "start_at",              null: false
    t.datetime "end_at"
    t.datetime "registration_start_at"
    t.datetime "registration_end_at"
    t.string   "place",                 null: false
    t.text     "note"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["start_at"], name: "index_schedules_on_start_at", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                    null: false
    t.string   "email",      default: "", null: false
    t.string   "sign_in_id",              null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["sign_in_id"], name: "index_users_on_sign_in_id", unique: true, using: :btree
  end

end
