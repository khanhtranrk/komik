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

ActiveRecord::Schema[7.0].define(version: 2023_01_28_114236) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", default: ""
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "chapters", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "posted_at", default: "2023-01-30 10:42:03"
    t.boolean "free", default: false
    t.bigint "comic_id", null: false
    t.index ["comic_id"], name: "index_chapters_on_comic_id"
  end

  create_table "comics", force: :cascade do |t|
    t.string "image"
    t.string "name", null: false
    t.string "other_names", default: ""
    t.string "author", default: ""
    t.string "status", default: ""
    t.integer "views", default: 0
    t.integer "likes", default: 0
    t.text "description", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comics_categories", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "comic_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id", "comic_id"], name: "index_comics_categories_on_category_id_and_comic_id", unique: true
  end

  create_table "follows", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "comic_id", null: false
    t.index ["user_id", "comic_id"], name: "index_follows_on_user_id_and_comic_id", unique: true
  end

  create_table "images", force: :cascade do |t|
    t.string "url", null: false
    t.string "imageable_type", null: false
    t.bigint "imageable_id", null: false
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "comic_id", null: false
    t.index ["user_id", "comic_id"], name: "index_likes_on_user_id_and_comic_id", unique: true
  end

  create_table "refresh_tokens", force: :cascade do |t|
    t.string "token"
    t.bigint "user_id", null: false
    t.datetime "expire_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_refresh_tokens_on_token", unique: true
    t.index ["user_id"], name: "index_refresh_tokens_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "firstname", default: ""
    t.string "lastname", default: ""
    t.date "birthday", null: false
    t.integer "role", default: 0
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "chapters", "comics"
  add_foreign_key "refresh_tokens", "users"
end
