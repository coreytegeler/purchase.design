class AddDeleteToPostImages < ActiveRecord::Migration
  def change
  	add_column "post_images", "delete", :boolean
  end
end
