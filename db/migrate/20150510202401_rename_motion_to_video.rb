class RenameMotionToVideo < ActiveRecord::Migration[4.2]
  def change
  	remove_attachment 'works', 'motion'
  	add_attachment 'works', 'video'
  end
end
