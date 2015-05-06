class AddFirstAndLastNameToAlumni < ActiveRecord::Migration
  def change
  	add_column 'alumni', 'first_name', :string
  	add_column 'alumni', 'last_name', :string
  end
end
