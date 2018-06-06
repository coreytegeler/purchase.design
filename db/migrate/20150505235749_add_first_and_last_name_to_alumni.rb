class AddFirstAndLastNameToAlumni < ActiveRecord::Migration[4.2]
  def change
  	add_column 'alumni', 'first_name', :string
  	add_column 'alumni', 'last_name', :string
  end
end
