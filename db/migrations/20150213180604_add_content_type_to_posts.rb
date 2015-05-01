class AddContentTypeToPosts < ActiveRecord::Migration
  def change
  	add_column("posts", "content_type", :string)
  end
end
