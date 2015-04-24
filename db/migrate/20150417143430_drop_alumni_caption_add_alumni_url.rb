class DropAlumniCaptionAddAlumniUrl < ActiveRecord::Migration
  def change
  	remove_column "alumni", "caption"
  	add_column "alumni", "url", "string"
  end
end
