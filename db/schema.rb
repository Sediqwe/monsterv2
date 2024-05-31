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

ActiveRecord::Schema[7.0].define(version: 2024_05_31_184210) do
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gname"
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
    t.string "kuki"
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

  create_table "datatranslates", force: :cascade do |t|
    t.bigint "beolva_id", null: false
    t.bigint "databeolva_id", null: false
    t.text "data"
    t.integer "row"
    t.integer "col"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beolva_id"], name: "index_datatranslates_on_beolva_id"
    t.index ["databeolva_id"], name: "index_datatranslates_on_databeolva_id"
    t.index ["user_id"], name: "index_datatranslates_on_user_id"
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

  create_table "errorvans", force: :cascade do |t|
    t.string "page"
    t.string "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "forum_categories", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.string "color", default: "000000"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "forum_posts", id: :serial, force: :cascade do |t|
    t.integer "forum_thread_id"
    t.integer "user_id"
    t.text "body"
    t.boolean "solved", default: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "forum_subscriptions", id: :serial, force: :cascade do |t|
    t.integer "forum_thread_id"
    t.integer "user_id"
    t.string "subscription_type"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "forum_threads", id: :serial, force: :cascade do |t|
    t.integer "forum_category_id"
    t.integer "user_id"
    t.string "title", null: false
    t.string "slug", null: false
    t.integer "forum_posts_count", default: 0
    t.boolean "pinned", default: false
    t.boolean "solved", default: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "forums", force: :cascade do |t|
    t.string "title"
    t.text "desc"
    t.bigint "user_id", null: false
    t.boolean "online", default: true
    t.boolean "al"
    t.integer "fo_forum"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "gamemessages", force: :cascade do |t|
    t.text "message"
    t.boolean "accept"
    t.bigint "game_id", null: false
    t.boolean "reply"
    t.bigint "gamemessage_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "username"
    t.index ["game_id"], name: "index_gamemessages_on_game_id"
    t.index ["gamemessage_id"], name: "index_gamemessages_on_gamemessage_id"
    t.index ["user_id"], name: "index_gamemessages_on_user_id"
  end

  create_table "gamereqs", force: :cascade do |t|
    t.text "gamename"
    t.text "gamelink"
    t.bigint "user_id"
    t.text "username"
    t.bigint "game_id"
    t.text "desc"
    t.boolean "oke", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "valasz"
    t.index ["game_id"], name: "index_gamereqs_on_game_id"
    t.index ["user_id"], name: "index_gamereqs_on_user_id"
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
    t.boolean "stipi", default: false
    t.boolean "hidden", default: false
    t.datetime "hatarido"
    t.boolean "okes", default: false
    t.string "stipiusername"
    t.index ["name"], name: "index_games_on_name", unique: true
    t.index ["slug"], name: "index_games_on_slug", unique: true
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "gemorsses", force: :cascade do |t|
    t.text "user"
    t.text "desc"
    t.string "ido"
    t.boolean "okes"
    t.text "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "special"
    t.string "idouj"
    t.datetime "idouj3"
    t.index ["link"], name: "index_gemorsses_on_link"
  end

  create_table "gmessages", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.bigint "game_id", null: false
    t.bigint "gmessage_id"
    t.boolean "warn"
    t.bigint "senduser_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["game_id"], name: "index_gmessages_on_game_id"
    t.index ["gmessage_id"], name: "index_gmessages_on_gmessage_id"
    t.index ["senduser_id"], name: "index_gmessages_on_senduser_id"
    t.index ["user_id"], name: "index_gmessages_on_user_id"
  end

  create_table "hopps", force: :cascade do |t|
    t.text "link"
    t.string "gen"
    t.integer "open", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
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

  create_table "kukis", force: :cascade do |t|
    t.string "ertek"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "desc"
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

  create_table "pms", force: :cascade do |t|
    t.string "subject"
    t.integer "user"
    t.integer "sender"
    t.boolean "read"
    t.boolean "torolt"
    t.boolean "warn"
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

  create_table "stipis", force: :cascade do |t|
    t.text "desc"
    t.bigint "user_id", null: false
    t.boolean "okes", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "gamename"
    t.index ["user_id"], name: "index_stipis_on_user_id"
  end

  create_table "supporters", force: :cascade do |t|
    t.string "name"
    t.string "datum"
    t.integer "euro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supportlists", force: :cascade do |t|
    t.string "link"
    t.string "name"
    t.bigint "user_id", null: false
    t.boolean "active", default: true
    t.string "iconbootstrap"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_supportlists_on_user_id"
  end

  create_table "todos", force: :cascade do |t|
    t.string "name"
    t.text "desc"
    t.bigint "user_id", null: false
    t.integer "prio"
    t.boolean "kesz"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_todos_on_user_id"
  end

  create_table "translaters", force: :cascade do |t|
    t.text "translater_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "user_id", default: 0
    t.boolean "pm", default: false
    t.boolean "active", default: false
    t.index ["slug"], name: "index_translaters_on_slug", unique: true
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
    t.boolean "demo", default: false
    t.integer "sorrend", default: 0
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
    t.text "recovery"
    t.boolean "pm", default: false
    t.string "remember_token"
    t.boolean "mute", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
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

  create_table "youtubevideos", force: :cascade do |t|
    t.string "link"
    t.text "desc"
    t.boolean "okes"
    t.bigint "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "ready", default: true
    t.bigint "user_id", default: 1, null: false
    t.boolean "discord", default: false
    t.index ["game_id"], name: "index_youtubevideos_on_game_id"
    t.index ["link"], name: "index_youtubevideos_on_link", unique: true
    t.index ["user_id"], name: "index_youtubevideos_on_user_id"
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
  add_foreign_key "datatranslates", "beolvas"
  add_foreign_key "datatranslates", "databeolvas"
  add_foreign_key "datatranslates", "users"
  add_foreign_key "downloads", "games"
  add_foreign_key "downloads", "uploads"
  add_foreign_key "forum_posts", "forum_threads"
  add_foreign_key "forum_posts", "users"
  add_foreign_key "forum_subscriptions", "forum_threads"
  add_foreign_key "forum_subscriptions", "users"
  add_foreign_key "forum_threads", "forum_categories"
  add_foreign_key "forum_threads", "users"
  add_foreign_key "forums", "users"
  add_foreign_key "gamemessages", "gamemessages"
  add_foreign_key "gamemessages", "games"
  add_foreign_key "gamereqs", "games"
  add_foreign_key "gamereqs", "users"
  add_foreign_key "games", "users"
  add_foreign_key "gmessages", "games"
  add_foreign_key "gmessages", "gmessages"
  add_foreign_key "gmessages", "users"
  add_foreign_key "gmessages", "users", column: "senduser_id"
  add_foreign_key "lemurs", "projects"
  add_foreign_key "news", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "regexadatoks", "projects"
  add_foreign_key "scanners", "beolvas"
  add_foreign_key "stipis", "users"
  add_foreign_key "supportlists", "users"
  add_foreign_key "todos", "users"
  add_foreign_key "uploads", "games"
  add_foreign_key "uploads", "platforms"
  add_foreign_key "uploads", "programs"
  add_foreign_key "uploads", "translaters"
  add_foreign_key "uploads", "users"
  add_foreign_key "uploadtranslaters", "translaters"
  add_foreign_key "uploadtranslaters", "uploads"
  add_foreign_key "uzenets", "users"
  add_foreign_key "youtubevideos", "users"
end
