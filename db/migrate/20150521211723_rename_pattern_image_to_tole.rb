class RenamePatternImageToTole < ActiveRecord::Migration
  def change
  	rename_column :patterns, :image_file_name, :tile_file_name
    rename_column :patterns, :image_file_size, :tile_file_size
    rename_column :patterns, :image_content_type, :tile_content_type
    rename_column :patterns, :image_updated_at, :tile_updated_at 
  end
end
