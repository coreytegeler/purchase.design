class AddSemesterAndYearToCourses < ActiveRecord::Migration[5.2]
  def change
  	add_column 'courses', 'year', :integer
  	add_column 'courses', 'semester', :string
  end
end
