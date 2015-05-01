class RenameWeblogToPosts < ActiveRecord::Migration
  def change
  	rename_table 'weblog', 'posts'
  end
end
