class CreateApplyItem < ActiveRecord::Migration
  def change
    create_table :apply_items do |t|
    	t.string :text
    	t.integer :position
    	t.text :type
    end
  end
end
