class Gradient < ActiveRecord::Base

	scope :sorted, lambda {order("gradients.position ASC")}
	scope :newest_first, lambda {order("gradients.created_at ASC")}

	acts_as_list scope: [:position]

	before_validation :create_name

	has_attached_file :file
	do_not_validate_attachment_file_type :file

	private

		def create_name
			if name.blank?
				self.name = "Gradient No." + " #{position}"
			end
		end
end
