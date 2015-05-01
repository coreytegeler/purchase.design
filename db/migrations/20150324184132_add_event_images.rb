class AddEventImages < ActiveRecord::Migration

  def change
  	create_table :event_images do |t|
      t.attachment :image
      t.integer "event_id"
      t.timestamps null: false
  	end
  end

end
