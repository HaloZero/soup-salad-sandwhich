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

ActiveRecord::Schema.define(version: 2019_08_05_011616) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "food_votes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "session_id"
    t.string "food_type"
  end

  create_table "photos", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "asset_name"
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "photo_id"
    t.string "food_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "session_id"
    t.index ["photo_id"], name: "index_votes_on_photo_id"
    t.index ["session_id"], name: "index_votes_on_session_id"
  end

  add_foreign_key "votes", "photos"
end
