class AddDeleteToPostImages < ActiveRecord::Migration[4.2]
  def change
  	add_column "post_images", "delete", :boolean
  end
end
