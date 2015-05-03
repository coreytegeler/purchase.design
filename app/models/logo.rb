class Logo < ActiveRecord::Base

	scope :sorted, lambda {order("logos.position ASC")}
	scope :newest_first, lambda {order("logos.created_at ASC")}

	acts_as_list scope: [:position]

	before_validation :create_name

	has_attached_file :file
	do_not_validate_attachment_file_type :file

	private

		def create_name
			if name.blank?
				self.name = "Logo No." + " #{position}"
			end
		end
end
