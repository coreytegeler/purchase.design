class AddPositionToFaculty < ActiveRecord::Migration
  def change
  	add_column "faculties", "position", :integer
  end
end
