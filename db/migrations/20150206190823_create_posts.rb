class CreatePosts < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.string "title"
      t.string "category"
      t.string "permalink"
      t.integer "position"
      t.text "content"
      t.boolean "visible", :default => false
      t.timestamps null: false
    end
    add_index("posts", "permalink")
  end

  def down
  	drop_table :posts
  end
end
