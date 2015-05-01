class AddFacultyImage < ActiveRecord::Migration
  def change
  	add_attachment :faculties, :image
  end
end
