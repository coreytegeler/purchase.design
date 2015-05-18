class Logo < ActiveRecord::Base

	scope :first_to_last, lambda {order("logos.position ASC")}

	has_attached_file :file
 	validates_attachment_file_name :file, matches: [/svg\Z/]

	acts_as_list :order => :position
	
end
