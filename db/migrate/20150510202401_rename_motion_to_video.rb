class RenameMotionToVideo < ActiveRecord::Migration
  def change
  	remove_attachment 'works', 'motion'
  	add_attachment 'works', 'video'
  end
end
