class RenameAlmaMatresToAlmaMaters < ActiveRecord::Migration
  def change
  	rename_table "faculty_alma_matres", "alma_maters"
  end
end
