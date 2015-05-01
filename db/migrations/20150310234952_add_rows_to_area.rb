class AddRowsToArea < ActiveRecord::Migration
  def change
  	add_column("areas", "name", :string)
  	add_column("areas", "slug", :string)
  	add_column("areas", "position", :integer)
  	add_column("areas", "visible", :boolean)
  end
end
