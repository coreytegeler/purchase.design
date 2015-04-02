class RenameUsernameToFullName < ActiveRecord::Migration
  def change
  	rename_column("admins", "username", "full_name")
  end
end
