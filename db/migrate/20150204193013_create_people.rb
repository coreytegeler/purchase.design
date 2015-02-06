class CreatePeople < ActiveRecord::Migration
  def up
    create_table :people do |t|
      t.integer "group_id"
      t.string "name"
      t.string "permalink"
      t.integer "position"
      t.boolean "visible", :default => false
      t.timestamps null: false
    end
    add_index("people", "group_id")
    add_index("people", "permalink")
  end

  def down
  	drop_table :people
  end
end
