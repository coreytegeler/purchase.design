class AlterUsers < ActiveRecord::Migration
  def up
  	rename_column("users", "password", "hashed_password")
  	add_column("users", "username", :string, :limit => 25, :after => "email")
  	add_index("users", "username")
  end
  def down
  	remove_index("users", "username")
  	remove_column("users", "username")
	  rename_column("users", "hashed_password", "password")
  end
end
