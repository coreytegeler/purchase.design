class AddPositionAndRemoveFullNameFromAdmins < ActiveRecord::Migration[4.2]
  def change
  	#remove_column "admins", "full_name"
  	add_column "admins", "position", :integer
  end
end
