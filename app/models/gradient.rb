class Gradient < ActiveRecord::Base

	scope :first_to_last, lambda {order("gradients.position ASC")}

	acts_as_list scope: [:position]

	before_validation :create_name

	has_attached_file :file
	do_not_validate_attachment_file_type :file

	acts_as_list :order => :position

end
