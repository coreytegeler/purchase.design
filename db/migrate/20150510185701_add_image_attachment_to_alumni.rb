class AddImageAttachmentToAlumni < ActiveRecord::Migration
  def change
  	add_attachment 'alumni', 'image'
  end
end
