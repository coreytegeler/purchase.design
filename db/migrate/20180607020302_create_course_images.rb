class CreateCourseImages < ActiveRecord::Migration[5.2]
  def change
    create_table :course_images do |t|
			t.string   "image_file_name",    limit: 255
			t.string   "image_content_type", limit: 255
			t.integer  "image_file_size",    limit: 4
			t.datetime "image_updated_at"
			t.integer  "course_id",          limit: 4
			t.integer  "position",           limit: 4
			t.datetime "created_at"
			t.datetime "updated_at"
    end
  end
end
