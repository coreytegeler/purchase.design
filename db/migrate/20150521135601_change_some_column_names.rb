class ChangeSomeColumnNames < ActiveRecord::Migration
  def change
  	rename_column :patterns, :tile_file_name, :image_file_name
    rename_column :patterns, :tile_file_size, :image_file_size
    rename_column :patterns, :tile_content_type, :image_content_type
    rename_column :patterns, :tile_updated_at, :image_updated_at  
  	rename_column "alumni", "url", "link"
  	remove_column "works", "year"
  end
end
