class AddAbout < ActiveRecord::Migration
  def change
  	create_table :about do |t|
    	t.string :text
    end
  end
end
