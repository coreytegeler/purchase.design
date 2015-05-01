class MakeUsersAdmins < ActiveRecord::Migration
  def up
  	rename_table("users", "admins")
  end
  def down
	rename_table("admins", "users")
  end
end
