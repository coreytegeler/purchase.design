class RenameFacultyToFaculties < ActiveRecord::Migration
  def change
  	rename_table "faculty", "faculties"
  end
end
