class CreateApplyItem < ActiveRecord::Migration[4.2]
  def change
    create_table :apply_items do |t|
    	t.string :text
    	t.integer :position
    	t.text :type
    end
  end
end
