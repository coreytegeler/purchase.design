class AddLinkToFaculty < ActiveRecord::Migration
  def change
  	add_column 'faculties', 'link', :string
  end
end
