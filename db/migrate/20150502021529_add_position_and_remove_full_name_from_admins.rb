class AddPositionAndRemoveFullNameFromAdmins < ActiveRecord::Migration
  def change
  	#remove_column "admins", "full_name"
  	add_column "admins", "position", :integer
  end
end
