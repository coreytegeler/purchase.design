class DropFactultyAndRenameFacultyMembersToFaculty < ActiveRecord::Migration
  def change
  	drop_table "faculty"
  	rename_table "faculty_members", "faculty"
  end
end
