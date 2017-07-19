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

ActiveRecord::Schema.define(version: 20170718173920) do

  create_table "episodes", force: :cascade do |t|
    t.integer "podcast_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "media"
    t.string "title"
    t.integer "media_size"
    t.text "description"
    t.datetime "published_at"
    t.string "origin_id"
  end

  create_table "podcasts", force: :cascade do |t|
    t.string "origin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "source_type"
    t.index ["origin_id"], name: "index_podcasts_on_origin_id", unique: true
  end

end
