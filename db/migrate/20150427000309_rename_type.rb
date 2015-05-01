class RenameType < ActiveRecord::Migration
  def change
  	rename_column 'resources', 'type', 'category'
  	rename_column 'posts', 'type', 'category'
  end
end
