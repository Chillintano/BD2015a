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

ActiveRecord::Schema.define(version: 20151012192106) do

  create_table "assignments", force: true do |t|
    t.integer "repair_object_id", null: false
    t.integer "worker_id",        null: false
    t.date    "date_started",     null: false
    t.date    "date_finished"
    t.integer "pay",              null: false
    t.boolean "isTimed"
  end

  create_table "clients", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "foremen", force: true do |t|
    t.integer "worker_id",        null: false
    t.integer "repair_object_id", null: false
  end

  create_table "products", force: true do |t|
    t.string "description", null: false
  end

  create_table "repair_objects", force: true do |t|
    t.string  "description"
    t.integer "client_id",     null: false
    t.date    "date_started"
    t.date    "date_finished"
  end

  create_table "repair_products", force: true do |t|
    t.integer "product_id",       null: false
    t.integer "repair_object_id", null: false
    t.integer "volume"
  end

  create_table "transactions", force: true do |t|
    t.integer  "client_id",                        null: false
    t.integer  "repair_object_id",                 null: false
    t.integer  "product_id"
    t.integer  "volume"
    t.integer  "value",                            null: false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "income",           default: false
  end

  create_table "workers", force: true do |t|
    t.string "name", null: false
  end

end
