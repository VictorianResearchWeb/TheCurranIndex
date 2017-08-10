class CreateDatabase < ActiveRecord::Migration
  def up
    unless table_exists?("articles")
      create_table "articles", force: true do |t|
        t.integer "periodical_id"
        t.integer "month"
        t.integer "year"
        t.integer "page_start"
        t.integer "page_end"
        t.string  "code",                   limit: 6
        t.string  "title"
        t.string  "attribution"
        t.string  "article_type",           limit: 10, default: "prose"
        t.integer "volume"
        t.string  "attribution_confidence", limit: 10
        t.integer "issue_number"
        t.string  "entry_month",            limit: 7,  default: "(06/17)"
        t.integer "day"
        t.string  "payment",                limit: 8
      end

      add_index "articles", ["article_type"], name: "Article Type", using: :btree
      add_index "articles", ["code"], name: "Article Code", using: :btree
      add_index "articles", ["issue_number"], name: "Issue Number", using: :btree
      add_index "articles", ["page_start"], name: "Article Page Start", using: :btree
      add_index "articles", ["periodical_id"], name: "Periodical", using: :btree
      add_index "articles", ["year"], name: "Article Year", using: :btree
    end
    
    unless table_exists?("articles_contributors")
      create_table "articles_contributors", id: false, force: true do |t|
        t.integer "article_id"
        t.integer "contributor_id", default: 28
      end

      add_index "articles_contributors", ["article_id"], name: "Articles_ID", using: :btree
      add_index "articles_contributors", ["contributor_id"], name: "Contributors_ID", using: :btree
    end

    unless table_exists?("contributors")
      create_table "contributors", force: true do |t|
        t.string   "full_name"
        t.datetime "birth"
        t.datetime "death"
        t.string   "gender",      limit: 1
        t.text     "comment",     limit: 2147483647
        t.string   "education"
        t.string   "nationality", limit: 40
        t.string   "birth_year",  limit: 4
        t.string   "death_year",  limit: 4
        t.string   "identifier"
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
      create_table "essays", force: true do |t|
        t.integer "pub_month"
        t.integer "pub_year"
        t.text    "contents",  limit: 2147483647
      end
    end

    unless table_exists?("periodicals")
      create_table "periodicals", force: true do |t|
        t.string "name"
        t.string "abbreviation"
        t.text   "comment",       limit: 2147483647
        t.text   "postscript",    limit: 2147483647
        t.string "frequency",     limit: 5
      end
    end

  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end

end