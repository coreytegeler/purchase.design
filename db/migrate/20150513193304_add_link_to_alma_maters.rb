class AddLinkToAlmaMaters < ActiveRecord::Migration
  def change
  	add_column "alma_maters", "link", :string 
  end
end
