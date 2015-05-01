class AddColumnsToFaculty < ActiveRecord::Migration
  def change
	add_column "faculties", "title", :string
  	add_column "faculties", "email", :string
  end
end
