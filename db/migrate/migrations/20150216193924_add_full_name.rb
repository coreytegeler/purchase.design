class AddFullName < ActiveRecord::Migration
  def change
  	add_column("people", "name", :string)
  end
end
