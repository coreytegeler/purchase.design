class AddImageAttachmentToAlumni < ActiveRecord::Migration[4.2]
  def change
  	add_attachment 'alumni', 'image'
  end
end
