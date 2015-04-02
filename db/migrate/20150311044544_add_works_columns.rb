class AddWorksColumns < ActiveRecord::Migration
  def change
  	add_column("works", "designer", :string)
  	add_column("works", "statement", :text)
  end
end
