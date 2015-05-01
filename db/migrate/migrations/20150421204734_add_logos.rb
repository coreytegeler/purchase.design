class AddLogos < ActiveRecord::Migration
  def change
  	 create_table :logos do |t|
  	 	t.attachment "file"
  	 	t.integer "position"
  	 end
  end
end
