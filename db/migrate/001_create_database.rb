class CreateDatabase < ActiveRecord::Migration
  def up
    unless table_exists?("articles")
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
      t.string  "attribution_confidence", limit: 10
      t.integer "issue_number",           limit: 4
      t.string  "entry_month",            limit: 7,   default: "(06/17)"
      t.integer "day",                    limit: 4
      t.string  "payment",                limit: 8
    end

    add_index "articles", ["article_type"], name: "Article Type", using: :btree
    add_index "articles", ["article_year"], name: "Article Year", using: :btree
    add_index "articles", ["code"], name: "Article Code", using: :btree
    add_index "articles", ["issue_number"], name: "Issue Number", using: :btree
    add_index "articles", ["page_start"], name: "Article Page Start", using: :btree
    add_index "articles", ["periodical_id"], name: "Periodical", using: :btree
  end
    
    unless table_exists?("articles_contributors")
      create_table "articles_contributors", id: false, force: :cascade do |t|
        t.integer "article_id",     limit: 4
        t.integer "contributor_id", limit: 4, default: 28
      end

      add_index "articles_contributors", ["article_id"], name: "Articles_ID", using: :btree
      add_index "articles_contributors", ["contributor_id"], name: "Contributors_ID", using: :btree
    end

    unless table_exists?("contacts")
      create_table "contacts", primary_key: "email", force: :cascade do |t|
      end
    end

    unless table_exists?("contributors")
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
        t.boolean  "wellesley"
      end

      add_index "contributors", ["comment"], name: "Comment", length: {"comment"=>100}, using: :btree
      add_index "contributors", ["death"], name: "Death", using: :btree
      add_index "contributors", ["death_year"], name: "Death Year", using: :btree
      add_index "contributors", ["full_name"], name: "Full Name", using: :btree
      add_index "contributors", ["gender"], name: "Gender", using: :btree
      add_index "contributors", ["identifier"], name: "Identifier", using: :btree
      add_index "contributors", ["nationality"], name: "Nationality", using: :btree
    end

    unless table_exists?("essays")
      create_table "essays", force: :cascade do |t|
        t.integer "month_id", limit: 4
        t.integer "pub_year", limit: 4
        t.text    "contents", limit: 4294967295
      end
    end

    unless table_exists?("periodicals")
      create_table "periodicals", force: :cascade do |t|
        t.string "title",        limit: 255
        t.string "abbreviation", limit: 255
        t.text   "comment",      limit: 4294967295
        t.text   "postscript",   limit: 4294967295
        t.string "frequency",    limit: 5
      end
    end

    unless table_exists?("months")
      create_table "months", force: :cascade do |t|
        t.string "publication_month", limit: 3
      end
    end

    unless table_exists?("notes")
      create_table "notes", force: :cascade do |t|
        t.string "source",      limit: 255
        t.text   "information", limit: 4294967295
      end
    end

  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end

end







