class AddAbout < ActiveRecord::Migration[4.2]
  def change
  	create_table :about do |t|
    	t.string :text
    end
  end
end
