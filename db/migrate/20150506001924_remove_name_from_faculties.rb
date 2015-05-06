class RemoveNameFromFaculties < ActiveRecord::Migration
  def change
  	remove_column 'faculties', 'name'
  end
end
