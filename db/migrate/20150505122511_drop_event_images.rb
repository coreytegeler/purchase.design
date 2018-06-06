class DropEventImages < ActiveRecord::Migration[4.2]
  def change
  	drop_table 'event_images'
  end
end
