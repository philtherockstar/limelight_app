# encoding: UTF-8
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

class CreateInitialSchema < ActiveRecord::Migration

 def self.up

  create_table "bid_details", force: true do |t|
    t.integer "bid_id",        limit: 11
    t.integer "room_id",       limit: 11
    t.integer "room_instance", limit: 11
    t.string  "room_name",     limit: 64
    t.integer "item_id",       limit: 11
    t.string  "item_name",     limit: 64
    t.decimal "rental_price",             precision: 5, scale: 2
  end

  add_index "bid_details", ["bid_id"], name: "bid_details_bid_details_fk1_idx"
  add_index "bid_details", ["item_id"], name: "bid_details_bid_details_fk3_idx"
  add_index "bid_details", ["room_id"], name: "bid_details_bid_details_fk2_idx"

  create_table "bid_room_items", force: true do |t|
    t.integer "bid_id",        limit: 11,                         null: false
    t.integer "bid_room_id",   limit: 11,                         null: false
    t.integer "room_id",       limit: 11
    t.integer "room_instance", limit: 11,                         null: false
    t.string  "room_name",     limit: 64
    t.integer "item_id",       limit: 11,                         null: false
    t.string  "item_name",     limit: 64
    t.integer "item_qty",      limit: 11,                         null: false
    t.decimal "rental_price",             precision: 5, scale: 2, null: false
  end

  add_index "bid_room_items", ["bid_id"], name: "bid_room_items_fk1_idx"
  add_index "bid_room_items", ["bid_room_id", "room_instance", "item_id"], name: "bid_room_items_ci2"
  add_index "bid_room_items", ["bid_room_id", "room_instance"], name: "bid_room_items_ci1"
  add_index "bid_room_items", ["bid_room_id"], name: "bid_room_items_fk2_idx"
  add_index "bid_room_items", ["item_id"], name: "bid_room_items_fk4_idx"
  add_index "bid_room_items", ["room_id"], name: "bid_room_items_fk3_idx"

  create_table "bid_rooms", force: true do |t|
    t.integer "bid_id",    limit: 11, null: false
    t.integer "room_id",   limit: 11, null: false
    t.integer "num_rooms", limit: 11
  end

  add_index "bid_rooms", ["bid_id"], name: "bid_rooms_idx1"

  create_table "bids", force: true do |t|
    t.integer  "property_id",         limit: 11,                                       null: false
    t.datetime "bid_date"
    t.decimal  "staging_fee",                    precision: 5, scale: 2
    t.decimal  "distribution_fee",               precision: 5, scale: 2
    t.decimal  "rental_weekly",                  precision: 5, scale: 2
    t.decimal  "rental_monthly",                 precision: 5, scale: 2
    t.decimal  "rental",                         precision: 5, scale: 2
    t.integer  "weeks_included",      limit: 4
    t.integer  "complimentary_weeks", limit: 4
    t.integer  "discount_percent",    limit: 4,                          default: 0
    t.decimal  "discount_amount",                precision: 5, scale: 2, default: 0.0
  end

  add_index "bids", ["property_id", "bid_date"], name: "bids_bids_uidx1"
  add_index "bids", ["property_id"], name: "bids_bids_idx1"

  create_table "business_cities", force: true do |t|
    t.integer "business_id"
    t.string  "city",        limit: 128, null: false
    t.integer "city_order",              null: false
  end

  create_table "businesses", force: true do |t|
    t.string "name", limit: 128, null: false
  end

  add_index "businesses", ["name"], name: "businesses_name_UNIQUE"

  create_table "countries", force: true do |t|
    t.string  "iso",            limit: 2,  default: "", null: false
    t.string  "name",           limit: 80, default: "", null: false
    t.string  "printable_name", limit: 80, default: "", null: false
    t.string  "iso3",           limit: 3
    t.integer "numcode",        limit: 6
  end

  create_table "items", force: true do |t|
    t.string  "name",         limit: 128,                         null: false
    t.decimal "rental_price",             precision: 5, scale: 2, null: false
  end

  add_index "items", ["name", "rental_price"], name: "items_item_name_rental_price_ui1"

  create_table "properties", force: true do |t|
    t.string  "address",          limit: 128, null: false
    t.string  "city",             limit: 128, null: false
    t.integer "state_id",         limit: 11
    t.integer "province_id",      limit: 11
    t.integer "country_id",       limit: 11,  null: false
    t.integer "sqft",             limit: 11
    t.integer "listing_price",    limit: 11
    t.integer "selling_price",    limit: 11
    t.date    "est_closing_date"
    t.text    "status"
    t.integer "business_id",      limit: 11,  null: false
  end

  add_index "properties", ["business_id", "address"], name: "properties_properties_idx1"
  add_index "properties", ["business_id"], name: "properties_properties_fk1_idx"
  add_index "properties", ["country_id"], name: "properties_properties_fk3_idx"
  add_index "properties", ["state_id"], name: "properties_properties_fk2_idx"

  create_table "property_bid_rooms", force: true do |t|
    t.integer "bid_id",      limit: 11, null: false
    t.integer "property_id", limit: 11, null: false
    t.integer "room_id",     limit: 11, null: false
    t.integer "num_rooms",   limit: 11
  end

  create_table "property_rooms", force: true do |t|
    t.integer "property_id", limit: 11, null: false
    t.integer "room_id",     limit: 11, null: false
    t.integer "num_rooms",   limit: 11
  end

  create_table "room_items", force: true do |t|
    t.integer "room_id", limit: 11, null: false
    t.integer "item_id", limit: 11, null: false
  end

  add_index "room_items", ["item_id"], name: "room_items_room_items_fk2"
  add_index "room_items", ["room_id"], name: "room_items_room_items_fk1"

  create_table "rooms", force: true do |t|
    t.string  "name",          limit: 128, null: false
    t.string  "abbr",          limit: 8
    t.integer "display_order", limit: 11
  end

  add_index "rooms", ["name"], name: "rooms_name_UNIQUE"

  create_table "states", force: true do |t|
    t.string "name",   limit: 40, default: "", null: false
    t.string "abbrev", limit: 2,  default: "", null: false
  end

  create_table "template_room_items", force: true do |t|
    t.integer "business_id"
    t.integer "room_id",     limit: 11
    t.integer "item_id",     limit: 11
    t.integer "quantity",               default: 1
  end

  add_index "template_room_items", ["business_id", "room_id"], name: "template_room_items_idx2"
  add_index "template_room_items", ["room_id"], name: "template_room_items_idx1"

 end

 def self.down
 end

end
