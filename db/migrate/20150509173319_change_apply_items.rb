class ChangeApplyItems < ActiveRecord::Migration
  def change
  	remove_column "apply_items", "show_to"
  	remove_column "apply_items", "text"
  	add_column "apply_items", "student", :text
  	add_column "apply_items", "parent", :text
  end
end
