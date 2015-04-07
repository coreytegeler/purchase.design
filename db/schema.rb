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

ActiveRecord::Schema.define(version: 20150407171546) do

  create_table "admins", force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "email",           limit: 255
    t.string   "full_name",       limit: 25
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "password_digest", limit: 255
  end

  add_index "admins", ["full_name"], name: "index_admins_on_full_name", using: :btree

  create_table "alma_maters", force: :cascade do |t|
    t.string  "college",    limit: 255
    t.string  "degree",     limit: 255
    t.date    "year"
    t.integer "faculty_id", limit: 4
  end

  create_table "alumni", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.date     "year"
    t.text     "caption",    limit: 65535
    t.integer  "position",   limit: 4
    t.boolean  "visible",    limit: 1,     default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "apply", force: :cascade do |t|
    t.text    "summary", limit: 65535
    t.boolean "visible", limit: 1,     default: false
  end

  create_table "event_images", force: :cascade do |t|
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.integer  "event_id",           limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "events", force: :cascade do |t|
    t.string  "name",     limit: 255
    t.text    "summary",  limit: 65535
    t.date    "date"
    t.integer "position", limit: 4
    t.boolean "visible",  limit: 1,     default: false
  end

  create_table "faculties", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.text     "summary",            limit: 65535
    t.date     "first_year"
    t.date     "last_year"
    t.boolean  "current",            limit: 1,     default: true
    t.boolean  "visible",            limit: 1,     default: false
    t.integer  "position",           limit: 4
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.string   "title",              limit: 255
    t.string   "email",              limit: 255
    t.string   "website",            limit: 255
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "slug",       limit: 255
    t.integer  "position",   limit: 4
    t.boolean  "visible",    limit: 1,   default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "groups", ["slug"], name: "index_groups_on_slug", using: :btree

  create_table "palettes", force: :cascade do |t|
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "name",            limit: 255
    t.string   "primary_color",   limit: 255
    t.string   "secondary_color", limit: 255
    t.integer  "position",        limit: 4
  end

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

  create_table "resource_types", force: :cascade do |t|
    t.string  "name",     limit: 255
    t.integer "position", limit: 4
    t.boolean "visible",  limit: 1,   default: false
  end

  create_table "resources", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "link",               limit: 255
    t.string   "type",               limit: 255
    t.text     "caption",            limit: 65535
    t.integer  "position",           limit: 4
    t.boolean  "visible",            limit: 1,     default: false
    t.integer  "type_id",            limit: 4
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  create_table "students", force: :cascade do |t|
    t.text    "summary", limit: 65535
    t.boolean "visible", limit: 1,     default: false
  end

  create_table "visitors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "works", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "designer",            limit: 255
    t.date     "year"
    t.text     "caption",             limit: 65535
    t.integer  "position",            limit: 4
    t.boolean  "visible",             limit: 1,     default: false
    t.string   "image_file_name",     limit: 255
    t.string   "image_content_type",  limit: 255
    t.integer  "image_file_size",     limit: 4
    t.datetime "image_updated_at"
    t.string   "motion_file_name",    limit: 255
    t.string   "motion_content_type", limit: 255
    t.integer  "motion_file_size",    limit: 4
    t.datetime "motion_updated_at"
  end

end
