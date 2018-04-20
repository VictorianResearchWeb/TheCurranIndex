class CreatePageContents < ActiveRecord::Migration
  def change
    create_table :page_contents do |t|
      t.string :page_key
      t.text :html

      t.timestamps null: false
    end
  end
end
