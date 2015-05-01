class AddNameToLogos < ActiveRecord::Migration
  def change
  	add_column "logos", "name", :string
  end
end
