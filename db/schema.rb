# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_07_174232) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "moderators", id: :serial, force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", id: :serial, force: :cascade do |t|
    t.integer "story_id"
    t.string "attachment_file_name"
    t.string "attachment_content_type"
    t.integer "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stories", id: :serial, force: :cascade do |t|
    t.integer "year"
    t.text "body", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "lng", precision: 10, scale: 6
    t.boolean "approved", default: false, null: false
  end

  create_table "subscriptions", id: :serial, force: :cascade do |t|
    t.string "email", null: false
    t.boolean "validated", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
