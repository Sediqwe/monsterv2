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

ActiveRecord::Schema[7.0].define(version: 2023_09_17_080447) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activity_logs", force: :cascade do |t|
    t.string "user_id"
    t.string "browser"
    t.string "ip_address"
    t.string "controller"
    t.string "action"
    t.string "params"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "autoforditoilists", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.integer "tipus"
    t.boolean "active", default: true
    t.text "gname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_autoforditoilists_on_game_id"
  end

  create_table "beolva_changers", force: :cascade do |t|
    t.bigint "beolva_id", null: false
    t.bigint "changer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beolva_id"], name: "index_beolva_changers_on_beolva_id"
    t.index ["changer_id"], name: "index_beolva_changers_on_changer_id"
  end

  create_table "beolvas", force: :cascade do |t|
    t.string "game_name"
    t.string "game_version"
    t.boolean "trans"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fileend"
    t.integer "col"
    t.integer "copy"
    t.index ["user_id"], name: "index_beolvas_on_user_id"
  end

  create_table "blogs", force: :cascade do |t|
    t.string "title"
    t.text "desc"
    t.integer "blog_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cars", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "open"
    t.string "close"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "openc"
    t.string "closec"
    t.index ["user_id"], name: "index_cars_on_user_id"
  end

  create_table "changers", force: :cascade do |t|
    t.string "ori"
    t.string "mod"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chartos", force: :cascade do |t|
    t.bigint "beolva_id", null: false
    t.bigint "car_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beolva_id"], name: "index_chartos_on_beolva_id"
    t.index ["car_id"], name: "index_chartos_on_car_id"
  end

  create_table "databeolvas", force: :cascade do |t|
    t.bigint "beolva_id", null: false
    t.integer "row"
    t.integer "col"
    t.text "data"
    t.bigint "user_id", null: false
    t.integer "file_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "tdata"
    t.index ["beolva_id"], name: "index_databeolvas_on_beolva_id"
    t.index ["user_id"], name: "index_databeolvas_on_user_id"
  end

  create_table "dataprojects", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.text "data"
    t.text "tdata"
    t.integer "row"
    t.integer "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_dataprojects_on_project_id"
  end

  create_table "downloads", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "upload_id", null: false
    t.string "ip_address"
    t.index ["game_id"], name: "index_downloads_on_game_id"
    t.index ["upload_id"], name: "index_downloads_on_upload_id"
  end

  create_table "forums", force: :cascade do |t|
    t.string "title"
    t.text "desc"
    t.bigint "user_id", null: false
    t.boolean "active", default: true
    t.boolean "olvashato"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "forumtype", default: false
    t.integer "gameid"
    t.integer "forumpoint"
    t.index ["user_id"], name: "index_forums_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at", precision: nil
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.string "link_steam"
    t.text "description"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link_epic"
    t.string "link_other"
    t.string "slug"
    t.bigint "user_id", null: false
    t.string "link_hun"
    t.boolean "done"
    t.datetime "uploaded_at", precision: nil
    t.index ["slug"], name: "index_games_on_slug", unique: true
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "gemorsses", force: :cascade do |t|
    t.text "user"
    t.text "desc"
    t.date "ido"
    t.boolean "okes"
    t.text "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "special"
    t.index ["link"], name: "index_gemorsses_on_link", unique: true
  end

  create_table "hopps", force: :cascade do |t|
    t.text "link"
    t.string "gen"
    t.integer "open"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "howtos", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "poz"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "impressions", force: :cascade do |t|
    t.string "impressionable_type"
    t.integer "impressionable_id"
    t.integer "user_id"
    t.string "controller_name"
    t.string "action_name"
    t.string "view_name"
    t.string "request_hash"
    t.string "ip_address"
    t.string "session_hash"
    t.text "message"
    t.text "referrer"
    t.text "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
    t.index ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
    t.index ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
    t.index ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
    t.index ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index"
    t.index ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
    t.index ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
    t.index ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
    t.index ["user_id"], name: "index_impressions_on_user_id"
  end

  create_table "kukacs", force: :cascade do |t|
    t.string "title"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lemurs", force: :cascade do |t|
    t.string "str"
    t.bigint "project_id", null: false
    t.integer "line"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_lemurs_on_project_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "title"
    t.string "desc"
    t.boolean "active"
    t.string "list_type"
    t.string "link"
    t.integer "local"
    t.string "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "ready", default: true
  end

  create_table "login_attempts", force: :cascade do |t|
    t.string "ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "magyhursses", force: :cascade do |t|
    t.text "name"
    t.text "link"
    t.boolean "okes"
    t.date "ido"
    t.text "desc"
    t.text "uploader"
    t.text "meret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "magyhus", force: :cascade do |t|
    t.string "name"
    t.string "link"
    t.string "tipus"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "megas", force: :cascade do |t|
    t.string "title"
    t.string "link"
    t.boolean "active"
    t.string "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "szamlalo"
    t.integer "game"
  end

  create_table "messages", force: :cascade do |t|
    t.string "title"
    t.string "desc"
    t.bigint "user_id", null: false
    t.boolean "active"
    t.bigint "forumal_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["forumal_id"], name: "index_messages_on_forumal_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "news", force: :cascade do |t|
    t.string "title"
    t.text "desc"
    t.boolean "active"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_news_on_user_id"
  end

  create_table "platforms", force: :cascade do |t|
    t.text "platform_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prochartos", force: :cascade do |t|
    t.integer "file"
    t.integer "char"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "programs", force: :cascade do |t|
    t.text "program_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "game"
    t.integer "version"
    t.string "vege"
    t.integer "col"
    t.bigint "user_id", null: false
    t.integer "copy"
    t.boolean "trans"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "regexadatoks", force: :cascade do |t|
    t.string "indito"
    t.string "vege"
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_regexadatoks_on_project_id"
  end

  create_table "scanners", force: :cascade do |t|
    t.string "start"
    t.string "stop"
    t.bigint "beolva_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beolva_id"], name: "index_scanners_on_beolva_id"
  end

  create_table "translaters", force: :cascade do |t|
    t.text "translater_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uploads", force: :cascade do |t|
    t.string "name"
    t.string "version"
    t.text "description"
    t.bigint "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "translater"
    t.integer "platform"
    t.integer "program"
    t.bigint "translater_id", null: false
    t.bigint "program_id", null: false
    t.bigint "platform_id", null: false
    t.text "datum"
    t.boolean "bad"
    t.text "link_mega"
    t.boolean "special", default: false
    t.boolean "mauto", default: false
    t.boolean "multiuser", default: false
    t.index ["game_id"], name: "index_uploads_on_game_id"
    t.index ["platform_id"], name: "index_uploads_on_platform_id"
    t.index ["program_id"], name: "index_uploads_on_program_id"
    t.index ["translater_id"], name: "index_uploads_on_translater_id"
    t.index ["user_id"], name: "index_uploads_on_user_id"
  end

  create_table "uploadtranslaters", force: :cascade do |t|
    t.bigint "upload_id", null: false
    t.bigint "translater_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["translater_id"], name: "index_uploadtranslaters_on_translater_id"
    t.index ["upload_id"], name: "index_uploadtranslaters_on_upload_id"
  end

  create_table "user2s", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.string "email"
    t.boolean "admin"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "uploader"
    t.string "slug"
    t.text "alias"
    t.boolean "moderator", default: false
    t.text "desc"
    t.string "paypal"
    t.string "tam1"
    t.string "tam2"
    t.string "tam3"
    t.string "tam4"
    t.bigint "translater_id"
    t.index ["slug"], name: "index_users_on_slug", unique: true
    t.index ["translater_id"], name: "index_users_on_translater_id"
  end

  create_table "uzenets", force: :cascade do |t|
    t.text "desc"
    t.bigint "user_id", null: false
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "game_id"
    t.index ["game_id"], name: "index_uzenets_on_game_id"
    t.index ["user_id"], name: "index_uzenets_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "autoforditoilists", "games"
  add_foreign_key "beolva_changers", "beolvas"
  add_foreign_key "beolva_changers", "changers"
  add_foreign_key "beolvas", "users"
  add_foreign_key "cars", "users"
  add_foreign_key "chartos", "beolvas"
  add_foreign_key "chartos", "cars"
  add_foreign_key "databeolvas", "beolvas"
  add_foreign_key "databeolvas", "users"
  add_foreign_key "dataprojects", "projects"
  add_foreign_key "downloads", "games"
  add_foreign_key "downloads", "uploads"
  add_foreign_key "forums", "users"
  add_foreign_key "games", "users"
  add_foreign_key "lemurs", "projects"
  add_foreign_key "messages", "users"
  add_foreign_key "news", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "regexadatoks", "projects"
  add_foreign_key "scanners", "beolvas"
  add_foreign_key "uploads", "games"
  add_foreign_key "uploads", "platforms"
  add_foreign_key "uploads", "programs"
  add_foreign_key "uploads", "translaters"
  add_foreign_key "uploads", "users"
  add_foreign_key "uploadtranslaters", "translaters"
  add_foreign_key "uploadtranslaters", "uploads"
  add_foreign_key "uzenets", "users"
end
