class RemoveNameFromFaculties < ActiveRecord::Migration[4.2]
  def change
  	remove_column 'faculties', 'name'
  end
end
