class AddPatterns < ActiveRecord::Migration
  def change
  	create_table :patterns do |t|
  		t.attachment "tile"
  		t.integer "position"
  		t.string "name"
  	end
  end
end
