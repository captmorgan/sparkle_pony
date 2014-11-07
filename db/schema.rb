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

ActiveRecord::Schema.define(version: 20130606184553) do

  create_table "dashboard_queries", force: true do |t|
    t.string   "query"
    t.string   "group"
    t.string   "x_axis"
    t.string   "y_axis"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dashboard_id"
  end

  create_table "dashboards", force: true do |t|
    t.integer  "user_id"
    t.integer  "query_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "queries", force: true do |t|
    t.integer  "user_id"
    t.text     "output"
    t.integer  "rows"
    t.text     "input"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "report_sections", force: true do |t|
    t.integer  "report_id"
    t.integer  "index_order"
    t.text     "text"
    t.string   "db"
    t.string   "visual"
    t.string   "title"
    t.string   "time_graph"
    t.string   "group"
    t.string   "x_axis"
    t.string   "y_axis"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", force: true do |t|
    t.integer  "user_id"
    t.datetime "runtime"
    t.string   "cycle"
    t.string   "email_to_recipients"
    t.string   "email_cc_recipients"
    t.string   "email_subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
