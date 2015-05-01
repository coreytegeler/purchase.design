class AddGradients < ActiveRecord::Migration
  def change
  	create_table :gradients do |t|
  		t.attachment "file"
  		t.integer "position"
  		t.string "name"
  	end
  end
end
