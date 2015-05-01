class RenameVideo < ActiveRecord::Migration
  def change
  	drop_attached_file "works", "video"
  	add_attachment "works", "motion"
  end
end
