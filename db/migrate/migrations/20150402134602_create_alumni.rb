class CreateAlumni < ActiveRecord::Migration
  def change
    create_table :alumni do |t|
      t.string "name"
      t.date "year"
      t.text "caption"
      t.integer "position"
      t.boolean "visible", :default => false
      t.timestamps null: false
    end
  end
end
