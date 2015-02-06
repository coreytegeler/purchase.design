class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.integer "person_id"
      t.string "name"
      t.integer "position"
      t.boolean "visible", :default => false
      t.text "content_type"
      t.text "content"
      t.timestamps null: false
    end
    add_index("works", "person_id")
  end
end
