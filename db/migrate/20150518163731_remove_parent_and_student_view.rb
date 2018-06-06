class RemoveParentAndStudentView < ActiveRecord::Migration[4.2]
  def change
  	remove_column "apply_items", "parent"
  	remove_column "apply_items", "student"
  	add_column "apply_items", "text", :text
  end
end
