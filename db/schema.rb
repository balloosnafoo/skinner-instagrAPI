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

ActiveRecord::Schema.define(version: 20151003000839) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collections", force: :cascade do |t|
    t.string   "tag",        null: false
    t.integer  "begin_time"
    t.integer  "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "link",          null: false
    t.string   "caption"
    t.string   "username",      null: false
    t.string   "media_url",     null: false
    t.string   "media_type",    null: false
    t.integer  "collection_id", null: false
    t.integer  "tag_time",      null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
