class AddWebsiteToFaculty < ActiveRecord::Migration
  def change
  	add_column "faculties", "website", :string
  end
end
