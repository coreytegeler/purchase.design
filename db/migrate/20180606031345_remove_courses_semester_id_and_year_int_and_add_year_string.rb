class RemoveCoursesSemesterIdAndYearIntAndAddYearString < ActiveRecord::Migration[5.2]
  def change
  	remove_column "courses", "semester_id"
  	remove_column "courses", "year"
  	add_column "courses", "year", :text
  end
end
