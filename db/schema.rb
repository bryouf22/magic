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

ActiveRecord::Schema.define(version: 2020_11_12_002043) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alternate_frames", force: :cascade do |t|
    t.integer "card_id", null: false
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "alternatives", force: :cascade do |t|
    t.integer "card_id"
    t.integer "alternative_card_id"
    t.integer "alternative_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blocs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "release_date"
  end

  create_table "card_collections", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "card_decks", force: :cascade do |t|
    t.bigint "card_id"
    t.bigint "deck_id"
    t.integer "occurences_in_main_deck"
    t.integer "occurences_in_sideboard"
    t.index ["card_id", "deck_id"], name: "index_card_decks_on_card_id_and_deck_id"
    t.index ["card_id"], name: "index_card_decks_on_card_id"
    t.index ["deck_id"], name: "index_card_decks_on_deck_id"
  end

  create_table "card_lists", force: :cascade do |t|
    t.bigint "card_id"
    t.integer "card_listable_id"
    t.string "card_listable_type"
    t.integer "number"
    t.integer "foils_number"
    t.index ["card_id"], name: "index_card_lists_on_card_id"
    t.index ["card_listable_type", "card_listable_id"], name: "index_card_lists_on_card_listable_type_and_card_listable_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "name"
    t.integer "extension_set_id"
    t.integer "card_type"
    t.string "detailed_type"
    t.integer "rarity"
    t.text "text"
    t.integer "cmc"
    t.string "mana_cost"
    t.integer "color_ids", array: true
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "artist_name"
    t.integer "number_in_set"
    t.string "gatherer_link"
    t.integer "gatherer_id"
    t.string "name_clean"
    t.text "flavor_text"
    t.string "power_str"
    t.string "defense_str"
    t.string "color_indicator"
    t.integer "loyalty"
    t.integer "format", default: 0, null: false
    t.boolean "first_edition"
    t.boolean "is_double_card", default: false
    t.boolean "is_double_part", default: false
    t.boolean "hybrid", default: false
    t.integer "alternative_type", default: 0
    t.boolean "legend", default: false
    t.boolean "snow", default: false
    t.boolean "tribal", default: false
    t.string "subtypes"
    t.index ["card_type"], name: "index_cards_on_card_type"
    t.index ["cmc"], name: "index_cards_on_cmc"
    t.index ["detailed_type"], name: "index_cards_on_detailed_type"
    t.index ["extension_set_id"], name: "index_cards_on_extension_set_id"
    t.index ["mana_cost"], name: "index_cards_on_mana_cost"
    t.index ["name"], name: "index_cards_on_name"
    t.index ["name_clean"], name: "index_cards_on_name_clean"
    t.index ["subtypes"], name: "index_cards_on_subtypes"
    t.index ["text"], name: "index_cards_on_text"
  end

  create_table "categories", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "decks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "colors", array: true
    t.integer "format_ids", array: true
    t.integer "user_id"
    t.integer "status", default: 1, null: false
    t.string "slug"
    t.integer "color_ids", array: true
    t.integer "card_number"
    t.integer "card_in_main_deck"
    t.boolean "is_public", default: false
    t.text "description"
    t.integer "category_id"
    t.integer "format", default: 0, null: false
    t.integer "complete_percent"
  end

  create_table "extension_sets", force: :cascade do |t|
    t.string "name"
    t.datetime "release_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "set_type"
    t.integer "bloc_id"
    t.integer "set_list_id"
    t.string "code"
    t.integer "card_count"
    t.integer "new_card_count"
    t.integer "reprint_count"
  end

  create_table "format_cards", force: :cascade do |t|
    t.bigint "format_id"
    t.bigint "card_id"
    t.boolean "forbidden"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_format_cards_on_card_id"
    t.index ["format_id"], name: "index_format_cards_on_format_id"
  end

  create_table "format_extensions", force: :cascade do |t|
    t.bigint "format_id"
    t.bigint "extension_set_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["extension_set_id"], name: "index_format_extensions_on_extension_set_id"
    t.index ["format_id"], name: "index_format_extensions_on_format_id"
  end

  create_table "formats", force: :cascade do |t|
    t.string "name"
    t.integer "card_limit"
    t.integer "card_occurence_limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gatherer_card_urls", force: :cascade do |t|
    t.string "url"
    t.integer "extension_set_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reprints", force: :cascade do |t|
    t.bigint "card_id"
    t.bigint "reprint_card_id"
    t.index ["card_id", "reprint_card_id"], name: "index_reprints_on_card_id_and_reprint_card_id"
    t.index ["card_id"], name: "index_reprints_on_card_id"
    t.index ["reprint_card_id"], name: "index_reprints_on_reprint_card_id"
  end

  create_table "set_lists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname"
    t.string "avatar"
    t.text "presentation"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wishlists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "name"
    t.string "slug", null: false
  end

end
