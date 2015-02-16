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

ActiveRecord::Schema.define(version: 20150216193924) do

  create_table "admins", force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "email",           limit: 255
    t.string   "username",        limit: 25
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "password_digest", limit: 255
  end

  add_index "admins", ["username"], name: "index_admins_on_username", using: :btree

  create_table "admins_groups", id: false, force: :cascade do |t|
    t.integer "admin_id", limit: 4
    t.integer "group_id", limit: 4
  end

  add_index "admins_groups", ["admin_id", "group_id"], name: "index_admins_groups_on_admin_id_and_group_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "slug",       limit: 255
    t.integer  "position",   limit: 4
    t.boolean  "visible",    limit: 1,   default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "groups", ["slug"], name: "index_groups_on_slug", using: :btree

  create_table "groups_posts", id: false, force: :cascade do |t|
    t.integer "group_id", limit: 4
    t.integer "post_id",  limit: 4
  end

  add_index "groups_posts", ["group_id", "post_id"], name: "index_groups_posts_on_group_id_and_post_id", using: :btree

  create_table "people", force: :cascade do |t|
    t.integer  "group_id",   limit: 4
    t.string   "first_name", limit: 255
    t.string   "slug",       limit: 255
    t.integer  "position",   limit: 4
    t.boolean  "visible",    limit: 1,   default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "grad_year",  limit: 4
    t.string   "last_name",  limit: 255
    t.string   "name",       limit: 255
  end

  add_index "people", ["group_id"], name: "index_people_on_group_id", using: :btree
  add_index "people", ["slug"], name: "index_people_on_slug", using: :btree

  create_table "person_edits", force: :cascade do |t|
    t.integer  "admin_id",   limit: 4
    t.integer  "person_id",  limit: 4
    t.string   "summary",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "person_edits", ["admin_id", "person_id"], name: "index_person_edits_on_admin_id_and_person_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.string   "category",     limit: 255
    t.string   "slug",         limit: 255
    t.integer  "position",     limit: 4
    t.text     "content",      limit: 65535
    t.boolean  "visible",      limit: 1,     default: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "content_type", limit: 255
  end

  add_index "posts", ["slug"], name: "index_posts_on_slug", using: :btree

  create_table "works", force: :cascade do |t|
    t.integer  "person_id",    limit: 4
    t.string   "title",        limit: 255
    t.integer  "position",     limit: 4
    t.boolean  "visible",      limit: 1,     default: false
    t.text     "content_type", limit: 65535
    t.text     "content",      limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.date     "date"
    t.string   "slug",         limit: 255
  end

  add_index "works", ["person_id"], name: "index_works_on_person_id", using: :btree

end
