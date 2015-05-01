class CreateTablesForSections < ActiveRecord::Migration
  def change

    create_table :students do |t|
      t.text "summary"
      t.boolean "visible", :default => false
    end

    create_table :works do |t|
      t.string "name"
      t.string "designer"
      t.date "year"
      t.text "caption"
      t.integer "position"
      t.boolean "visible", :default => false
    end

    create_table :faculty do |t|
      t.text "summary"
      t.boolean "visible", :default => false
    end

    create_table :faculty_members do |t|
      t.string "name"
      t.text "summary"
      t.date "first_year"
      t.date "last_year"
      t.boolean "current", :default => true
      t.boolean "visible", :default => false
    end

    create_table :apply do |t|
      t.text "summary"
      t.boolean "visible", :default => false
    end

    create_table :events do |t|
      t.string "name"
      t.text "summary"
      t.date "date"
      t.integer "position"
      t.boolean "visible", :default => false
    end

    create_table :resources do |t|
      t.string "name"
      t.string "link"
      t.string "type"
      t.text "summary"
      t.integer "position"
      t.boolean "visible", :default => false
    end

    create_table :resource_types do |t|
      t.string "name"
      t.integer "position"
      t.boolean "visible", :default => false
    end

  end
end
