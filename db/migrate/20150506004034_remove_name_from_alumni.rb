class RemoveNameFromAlumni < ActiveRecord::Migration
  def change
  	remove_column 'alumni', 'name'
  end
end
