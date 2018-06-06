class AddFirstAndLastNameToFaculties < ActiveRecord::Migration[4.2]
  def change
  	add_column 'faculties', 'first_name', :string
  	add_column 'faculties', 'last_name', :string
  end
end
