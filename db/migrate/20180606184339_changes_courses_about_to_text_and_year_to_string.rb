class ChangesCoursesAboutToTextAndYearToString < ActiveRecord::Migration[5.2]
  def change
  	remove_column "courses", "year"
  	add_column "courses", "year", :string
  	remove_column "courses", "about"
  	add_column "courses", "about", :text
  end
end
