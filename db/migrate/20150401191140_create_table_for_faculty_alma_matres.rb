class CreateTableForFacultyAlmaMatres < ActiveRecord::Migration
  def change
    create_table :faculty_alma_matres do |t|
    	t.string "college"
    	t.string "degree"
    	t.date "year"
    	t.integer "faculty_id"
    end
  end
end
