class RenameDeleteInPostImagesToRemove < ActiveRecord::Migration
  def change
  	rename_column 'post_images', 'delete', 'remove'
  end
end
