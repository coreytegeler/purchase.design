class AddImageToResources < ActiveRecord::Migration
  def change
  	add_attachment "resources", "image"
  end
end
