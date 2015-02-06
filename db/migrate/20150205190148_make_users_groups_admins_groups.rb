class MakeUsersGroupsAdminsGroups < ActiveRecord::Migration
  def up
  	rename_table("users_groups", "admins_groups")
  end
  def down
	rename_table("admins_groups", "users_groups")
  end
end
