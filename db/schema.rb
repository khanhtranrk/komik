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

ActiveRecord::Schema[7.0].define(version: 2023_02_28_195851) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", default: ""
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "chapters", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "posted_at", default: "2023-02-09 10:05:45"
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

  create_table "devices", force: :cascade do |t|
    t.bigint "login_id", null: false
    t.string "exponent_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exponent_token"], name: "index_devices_on_exponent_token", unique: true
  end

  create_table "feedbacks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "logins", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "token", null: false
    t.string "access_token", null: false
    t.datetime "expire_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "token"], name: "index_logins_on_user_id_and_token", unique: true
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.jsonb "message", null: false
    t.boolean "seen", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plans", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.float "price", null: false
    t.integer "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "plan_id", null: false
    t.float "price", null: false
    t.datetime "effective_date"
    t.datetime "expiry_date"
    t.string "payment_method", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reading_chapters", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "comic_id", null: false
    t.bigint "chapter_id", null: false
    t.index ["user_id", "comic_id"], name: "index_reading_chapters_on_user_id_and_comic_id", unique: true
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

  create_table "registries", force: :cascade do |t|
    t.string "key", null: false
    t.jsonb "value", null: false
    t.index ["key"], name: "index_registries_on_key", unique: true
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

  create_table "verifications", force: :cascade do |t|
    t.string "code", null: false
    t.datetime "expire_at", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_verifications_on_user_id", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "chapters", "comics"
  add_foreign_key "refresh_tokens", "users"
end
