class RenameDeleteInPostImagesToRemove < ActiveRecord::Migration[4.2]
  def change
  	rename_column 'post_images', 'delete', 'remove'
  end
end
