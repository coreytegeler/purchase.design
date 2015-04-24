class AddImageOrientation < ActiveRecord::Migration
  def change
  	add_column "works", "orientation", :string
  end
end
