class RemovesCoursesRequiresAddRequired < ActiveRecord::Migration[5.2]
  def change
  	remove_column "courses", "requires"
  	add_column "courses", "required", :integer
  end
end
