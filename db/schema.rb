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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130612220407) do

  create_table "airlines", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "key"
  end

  create_table "airports", :force => true do |t|
    t.string   "key"
    t.string   "name"
    t.integer  "city_id"
    t.integer  "km_to_city"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "generic_searches", :force => true do |t|
    t.integer  "city_from_id"
    t.integer  "city_to_id"
    t.integer  "priority"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "search_group_id"
    t.string   "when"
    t.boolean  "is_active"
  end

  add_index "generic_searches", ["city_from_id"], :name => "index_searches_on_city_from_id"
  add_index "generic_searches", ["city_to_id"], :name => "index_searches_on_city_to_id"

  create_table "results", :force => true do |t|
    t.integer  "search_id"
    t.integer  "source_id"
    t.integer  "airport_from_id"
    t.integer  "airport_to_id"
    t.datetime "departure"
    t.datetime "arrival"
    t.integer  "airline_id"
    t.integer  "stops"
    t.string   "currency"
    t.decimal  "price",           :precision => 10, :scale => 2, :default => 0.0
    t.time     "traveltime"
    t.datetime "created_at",                                                      :null => false
    t.datetime "updated_at",                                                      :null => false
  end

  create_table "routes", :force => true do |t|
    t.integer  "city_from_id"
    t.integer  "city_to_id"
    t.integer  "info_priority"
    t.boolean  "is_active"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "search_dates", :force => true do |t|
    t.date     "departure"
    t.date     "returndate"
    t.boolean  "is_active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "search_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sources", :force => true do |t|
    t.string   "name"
    t.string   "search_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "summaries", :force => true do |t|
    t.integer  "source_id"
    t.integer  "generic_search_id"
    t.integer  "airline_id"
    t.integer  "stops"
    t.string   "currency"
    t.decimal  "price",             :precision => 8, :scale => 2
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.integer  "search_date_id"
  end

end
