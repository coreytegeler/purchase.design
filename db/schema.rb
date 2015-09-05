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

ActiveRecord::Schema.define(version: 20150905201858) do

  create_table "abouts", force: :cascade do |t|
    t.text "text", limit: 65535
  end

  create_table "admins", force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "email",           limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "password_digest", limit: 255
    t.integer  "position",        limit: 4
  end

  create_table "alma_maters", force: :cascade do |t|
    t.string   "college",    limit: 255
    t.string   "degree",     limit: 255
    t.integer  "faculty_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "link",       limit: 255
  end

  create_table "alumni", force: :cascade do |t|
    t.integer  "position",           limit: 4
    t.boolean  "visible",            limit: 1,   default: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "link",               limit: 255
    t.string   "first_name",         limit: 255
    t.string   "last_name",          limit: 255
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  create_table "apply_items", force: :cascade do |t|
    t.integer "position", limit: 4
    t.text    "text",     limit: 65535
  end

  create_table "faculties", force: :cascade do |t|
    t.integer  "position",           limit: 4
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.string   "email",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",         limit: 255
    t.string   "last_name",          limit: 255
    t.string   "link",               limit: 255
  end

  create_table "gradients", force: :cascade do |t|
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size",    limit: 4
    t.datetime "file_updated_at"
    t.integer  "position",          limit: 4
    t.string   "name",              limit: 255
  end

  create_table "logos", force: :cascade do |t|
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size",    limit: 4
    t.datetime "file_updated_at"
    t.integer  "position",          limit: 4
  end

  create_table "palettes", force: :cascade do |t|
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "primary_color",   limit: 255
    t.string   "secondary_color", limit: 255
    t.integer  "position",        limit: 4
  end

  create_table "patterns", force: :cascade do |t|
    t.string   "tile_file_name",    limit: 255
    t.string   "tile_content_type", limit: 255
    t.integer  "tile_file_size",    limit: 4
    t.datetime "tile_updated_at"
    t.integer  "position",          limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_images", force: :cascade do |t|
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.integer  "post_id",            limit: 4
    t.integer  "position",           limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "remove",             limit: 1
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "body",       limit: 65535
    t.integer  "position",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_date"
    t.datetime "end_date"
  end

  create_table "resources", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "link",               limit: 255
    t.integer  "position",           limit: 4
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "works", force: :cascade do |t|
    t.string   "designer",           limit: 255
    t.integer  "position",           limit: 4
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "video_file_name",    limit: 255
    t.string   "video_content_type", limit: 255
    t.integer  "video_file_size",    limit: 4
    t.datetime "video_updated_at"
    t.string   "media_type",         limit: 255
  end

end
