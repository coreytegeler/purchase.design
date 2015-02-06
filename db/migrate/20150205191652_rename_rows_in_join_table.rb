class RenameRowsInJoinTable < ActiveRecord::Migration
  def up
  	rename_column("admins_groups", "user_id", "admin_id")
  end
  def down
	rename_column("admins_groups", "admin_id", "user_id")
  end
end
