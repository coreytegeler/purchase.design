class AddLinkToAlmaMaters < ActiveRecord::Migration[4.2]
  def change
  	add_column "alma_maters", "link", :string 
  end
end
