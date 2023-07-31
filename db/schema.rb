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

ActiveRecord::Schema[7.0].define(version: 2023_07_31_122510) do
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

  create_table "authors", force: :cascade do |t|
    t.string "firstname", null: false
    t.string "lastname", null: false
    t.datetime "birthday", null: false
    t.text "introduction", null: false
  end

  create_table "authors_comics", force: :cascade do |t|
    t.bigint "comic_id", null: false
    t.bigint "author_id", null: false
    t.index ["author_id"], name: "index_authors_comics_on_author_id"
    t.index ["comic_id", "author_id"], name: "index_authors_comics_on_comic_id_and_author_id", unique: true
    t.index ["comic_id"], name: "index_authors_comics_on_comic_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", default: ""
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "chapters", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "free", default: false
    t.bigint "comic_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comic_id"], name: "index_chapters_on_comic_id"
  end

  create_table "comics", force: :cascade do |t|
    t.string "name", null: false
    t.string "other_names", default: ""
    t.string "status", default: ""
    t.integer "views", default: 0
    t.integer "favorites", default: 0
    t.integer "follows", default: 0
    t.text "description", default: ""
    t.datetime "last_updated_chapter_at"
    t.datetime "release_date"
    t.integer "rating", default: 0
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comics_categories", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "comic_id", null: false
    t.index ["category_id", "comic_id"], name: "index_comics_categories_on_category_id_and_comic_id", unique: true
    t.index ["category_id"], name: "index_comics_categories_on_category_id"
    t.index ["comic_id"], name: "index_comics_categories_on_comic_id"
  end

  create_table "evaluates", force: :cascade do |t|
    t.integer "point_of_view"
    t.bigint "review_id", null: false
    t.bigint "user_id", null: false
    t.index ["review_id", "user_id"], name: "index_evaluates_on_review_id_and_user_id", unique: true
    t.index ["review_id"], name: "index_evaluates_on_review_id"
    t.index ["user_id"], name: "index_evaluates_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "comic_id", null: false
    t.index ["comic_id"], name: "index_favorites_on_comic_id"
    t.index ["user_id", "comic_id"], name: "index_favorites_on_user_id_and_comic_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.text "content", null: false
    t.boolean "resolved", default: false
    t.datetime "created_at", null: false
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "comic_id", null: false
    t.index ["comic_id"], name: "index_follows_on_comic_id"
    t.index ["user_id", "comic_id"], name: "index_follows_on_user_id_and_comic_id", unique: true
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.jsonb "message", null: false
    t.boolean "seen", default: false
    t.datetime "created_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.float "price", null: false
    t.integer "value", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_plans_on_deleted_at"
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "plan_id", null: false
    t.float "price", null: false
    t.datetime "effective_at"
    t.datetime "expires_at"
    t.string "payment_method", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_purchases_on_plan_id"
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "readings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "chapter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id"], name: "index_readings_on_chapter_id"
    t.index ["user_id", "chapter_id"], name: "index_readings_on_user_id_and_chapter_id", unique: true
    t.index ["user_id"], name: "index_readings_on_user_id"
  end

  create_table "registries", force: :cascade do |t|
    t.string "key", null: false
    t.jsonb "value", null: false
    t.index ["key"], name: "index_registries_on_key", unique: true
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "comic_id", null: false
    t.string "title", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comic_id"], name: "index_reviews_on_comic_id"
    t.index ["user_id", "comic_id"], name: "index_reviews_on_user_id_and_comic_id", unique: true
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "refresh_token", null: false
    t.string "access_token", null: false
    t.datetime "expire_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "refresh_token"], name: "index_sessions_on_user_id_and_refresh_token", unique: true
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "firstname", default: ""
    t.string "lastname", default: ""
    t.datetime "birthday", precision: nil, null: false
    t.integer "role", default: 0
    t.boolean "locked", default: false
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
    t.index ["user_id"], name: "index_verifications_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "authors_comics", "authors"
  add_foreign_key "authors_comics", "comics"
  add_foreign_key "chapters", "comics"
  add_foreign_key "comics_categories", "categories"
  add_foreign_key "comics_categories", "comics"
  add_foreign_key "evaluates", "reviews"
  add_foreign_key "evaluates", "users"
  add_foreign_key "favorites", "comics"
  add_foreign_key "favorites", "users"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "follows", "comics"
  add_foreign_key "follows", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "purchases", "plans"
  add_foreign_key "purchases", "users"
  add_foreign_key "readings", "chapters"
  add_foreign_key "readings", "users"
  add_foreign_key "reviews", "comics"
  add_foreign_key "reviews", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "verifications", "users"
end
