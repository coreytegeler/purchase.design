class AddImageWidthAndHeightToWorks < ActiveRecord::Migration
  def change
  	remove_column "works", "dimensions"
  	add_column "works", "width", :integer
  	add_column "works", "height", :integer
  end
end
