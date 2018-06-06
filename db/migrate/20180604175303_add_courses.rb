class AddCourses < ActiveRecord::Migration[5.2]
  def change
  	create_table "years", force: :cascade do |t|
			t.string   "name", limit: 255
			t.integer  "position", limit: 4
			t.datetime "created_at", null: false
			t.datetime "updated_at", null: false
		end

  	create_table "semesters", force: :cascade do |t|
			t.string   "name", limit: 255
			t.integer  "position", limit: 4
			t.integer  "year_id"
			t.datetime "created_at", null: false
			t.datetime "updated_at", null: false
		end

		create_table "courses", force: :cascade do |t|
			t.string   "name", limit: 255
			t.string   "about"
			t.integer  "position", limit: 4
			t.boolean  "requires"
			t.integer  "semester_id"
			t.datetime "created_at", null: false
			t.datetime "updated_at", null: false
		end
		
  end
end