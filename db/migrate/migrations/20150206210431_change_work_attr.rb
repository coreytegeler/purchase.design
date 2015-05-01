class ChangeWorkAttr < ActiveRecord::Migration
  def up
  	add_column("works", "date", :date)
  end
  def down
  	remove_column("works", "date")
  end
end
