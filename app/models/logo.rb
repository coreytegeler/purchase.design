class Logo < ActiveRecord::Base

	scope :first_to_last, lambda {order("logos.position ASC")}

	acts_as_list scope: [:position]

	before_validation :create_name

	has_attached_file :file
	do_not_validate_attachment_file_type :file

	acts_as_list :order => :position

	private

		def create_name
			if name.blank?
				self.name = "Logo No." + " #{position}"
			end
		end
end
