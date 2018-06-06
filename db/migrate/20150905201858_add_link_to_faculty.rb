class AddLinkToFaculty < ActiveRecord::Migration[4.2]
  def change
  	add_column 'faculties', 'link', :string
  end
end
