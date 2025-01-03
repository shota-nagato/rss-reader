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

ActiveRecord::Schema[7.2].define(version: 2024_12_29_123638) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feed_subscriptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "feed_id", null: false
    t.bigint "folder_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feed_id"], name: "index_feed_subscriptions_on_feed_id"
    t.index ["folder_id"], name: "index_feed_subscriptions_on_folder_id"
    t.index ["user_id"], name: "index_feed_subscriptions_on_user_id"
  end

  create_table "feeds", force: :cascade do |t|
    t.string "title", null: false
    t.string "url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "rss_url", null: false
    t.bigint "category_id"
    t.index ["category_id"], name: "index_feeds_on_category_id"
    t.index ["rss_url"], name: "index_feeds_on_rss_url", unique: true
  end

  create_table "folders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "options", default: {}, null: false
    t.index ["user_id"], name: "index_folders_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.bigint "feed_id", null: false
    t.string "title", null: false
    t.string "url", null: false
    t.string "image_url"
    t.datetime "published_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feed_id"], name: "index_items_on_feed_id"
  end

  create_table "user_items", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "item_id", null: false
    t.boolean "liked", default: false, null: false
    t.boolean "archived", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "bookmarked", default: false, null: false
    t.index ["item_id"], name: "index_user_items_on_item_id"
    t.index ["user_id"], name: "index_user_items_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.boolean "admin", default: false, null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "feed_subscriptions", "feeds"
  add_foreign_key "feed_subscriptions", "folders"
  add_foreign_key "feed_subscriptions", "users"
  add_foreign_key "feeds", "categories"
  add_foreign_key "folders", "users"
  add_foreign_key "items", "feeds"
  add_foreign_key "user_items", "items"
  add_foreign_key "user_items", "users"
end
