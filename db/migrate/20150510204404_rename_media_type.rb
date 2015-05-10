class RenameMediaType < ActiveRecord::Migration
  def change
  	rename_column 'works', 'media_types', 'media_type'
  end
end
