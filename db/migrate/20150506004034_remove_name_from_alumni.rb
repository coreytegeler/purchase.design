class RemoveNameFromAlumni < ActiveRecord::Migration[4.2]
  def change
  	remove_column 'alumni', 'name'
  end
end
