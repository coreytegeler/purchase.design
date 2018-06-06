class RenameApplyItemsType < ActiveRecord::Migration[4.2]
  def change
  	rename_column "apply_items", "type", "show_to"
  end
end
