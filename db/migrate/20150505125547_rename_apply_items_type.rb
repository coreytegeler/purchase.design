class RenameApplyItemsType < ActiveRecord::Migration
  def change
  	rename_column "apply_items", "type", "show_to"
  end
end
