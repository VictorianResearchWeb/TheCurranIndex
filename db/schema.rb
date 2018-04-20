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

ActiveRecord::Schema.define(version: 20180419234556) do

  create_table "articles", force: :cascade do |t|
    t.integer "periodical_id",          limit: 4
    t.integer "month_id",               limit: 4
    t.integer "article_year",           limit: 4
    t.integer "page_start",             limit: 4
    t.integer "page_end",               limit: 4
    t.string  "code",                   limit: 6
    t.string  "title",                  limit: 255
    t.string  "attribution",            limit: 255
    t.string  "article_type",           limit: 10,  default: "prose"
    t.integer "volume",                 limit: 4
    t.string  "attribution_confidence", limit: 10,  default: ""
    t.integer "issue_number",           limit: 4
    t.string  "entry_month",            limit: 7,   default: "(08/17)"
    t.integer "day",                    limit: 4
    t.string  "payment",                limit: 8
  end

  add_index "articles", ["article_type"], name: "article_type", using: :btree
  add_index "articles", ["article_year"], name: "article_year", using: :btree
  add_index "articles", ["code"], name: "code", using: :btree
  add_index "articles", ["issue_number"], name: "issue_number", using: :btree
  add_index "articles", ["page_start"], name: "page_start", using: :btree
  add_index "articles", ["periodical_id"], name: "periodical_id", using: :btree

  create_table "articles_contributors", id: false, force: :cascade do |t|
    t.integer "article_id",     limit: 4,              null: false
    t.integer "contributor_id", limit: 4, default: 28, null: false
  end

  add_index "articles_contributors", ["article_id"], name: "article_id", using: :btree
  add_index "articles_contributors", ["contributor_id"], name: "contributor_id", using: :btree

  create_table "contacts", primary_key: "email", force: :cascade do |t|
  end

  create_table "contributors", force: :cascade do |t|
    t.string   "full_name",   limit: 255
    t.datetime "birth"
    t.datetime "death"
    t.string   "gender",      limit: 1
    t.text     "comment",     limit: 4294967295
    t.string   "education",   limit: 255
    t.string   "nationality", limit: 40
    t.string   "birth_year",  limit: 4
    t.string   "death_year",  limit: 4
    t.string   "identifier",  limit: 255
    t.boolean  "wellesley",                      default: false
  end

  add_index "contributors", ["comment"], name: "comment", length: {"comment"=>100}, using: :btree
  add_index "contributors", ["death"], name: "death", using: :btree
  add_index "contributors", ["death_year"], name: "death_year", using: :btree
  add_index "contributors", ["full_name"], name: "full_name", using: :btree
  add_index "contributors", ["gender"], name: "gender", using: :btree
  add_index "contributors", ["identifier"], name: "identifier", using: :btree
  add_index "contributors", ["nationality"], name: "nationality", using: :btree

  create_table "essays", force: :cascade do |t|
    t.integer "pub_month", limit: 4
    t.integer "pub_year",  limit: 4
    t.text    "contents",  limit: 4294967295
  end

  create_table "months", force: :cascade do |t|
    t.string "publication_month", limit: 3
  end

  create_table "notes", force: :cascade do |t|
    t.string "source",      limit: 255
    t.text   "information", limit: 4294967295
  end

  create_table "page_contents", force: :cascade do |t|
    t.string   "page_key",   limit: 255
    t.text     "html",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "periodicals", force: :cascade do |t|
    t.string "title",        limit: 255
    t.string "abbreviation", limit: 255
    t.text   "comment",      limit: 4294967295
    t.text   "postscript",   limit: 4294967295
    t.string "frequency",    limit: 5
  end

end
