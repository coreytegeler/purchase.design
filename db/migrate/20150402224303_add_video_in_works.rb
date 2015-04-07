class AddVideoInWorks < ActiveRecord::Migration
  def change
  	add_attachment("works", "video")
  end
end
