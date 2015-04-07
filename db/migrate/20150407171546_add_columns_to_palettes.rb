class AddColumnsToPalettes < ActiveRecord::Migration
  def change
	add_column("palettes", "name", :string)
	add_column("palettes", "primary_color", :string)
	add_column("palettes", "secondary_color", :string)
	add_column("palettes", "position", :integer)
  end
end
