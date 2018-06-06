class RenameMediaType < ActiveRecord::Migration[4.2]
  def change
  	rename_column 'works', 'media_types', 'media_type'
  end
end
