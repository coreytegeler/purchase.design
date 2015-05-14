class Pattern < ActiveRecord::Base

	scope :first_to_last, lambda {order("patterns.position ASC")}

	has_attached_file :tile
  	validates_attachment_content_type :tile, :content_type => /^image\/(png|gif|jpeg)/

  	acts_as_list :order => :position

end
