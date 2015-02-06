class CreateGroups < ActiveRecord::Migration
  def up
    create_table :groups do |t|
      t.string "name"
      t.string "permalink"
      t.integer "position"
      t.boolean "visible", :default => false
      t.timestamps null: false
    end
    add_index("groups", "permalink")
  end

  def down
  	drop_table :groups
  end
end
