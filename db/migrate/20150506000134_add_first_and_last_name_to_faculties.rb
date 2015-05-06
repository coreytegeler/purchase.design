class AddFirstAndLastNameToFaculties < ActiveRecord::Migration
  def change
  	add_column 'faculties', 'first_name', :string
  	add_column 'faculties', 'last_name', :string
  end
end
