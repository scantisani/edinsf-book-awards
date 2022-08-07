# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_08_07_224958) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string "title", null: false
    t.string "author", null: false
    t.date "published_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "read_at", default: -> { "now()" }, null: false
    t.string "chosen_by", default: "Unknown", null: false
    t.index ["read_at"], name: "index_books_on_read_at", unique: true
  end

  create_table "rankings", force: :cascade do |t|
    t.bigint "book_id"
    t.integer "position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_rankings_on_book_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end

  add_foreign_key "rankings", "books"
end
