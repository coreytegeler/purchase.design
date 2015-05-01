class Pattern < ActiveRecord::Base

	scope :sorted, lambda {order("patterns.position ASC")}
	scope :new_to_old, lambda {order("patterns.created_at DESC")}
	scope :old_to_new, lambda {order("patterns.created_at ASC")}

	acts_as_list scope: [:position]

	before_validation :create_name

	has_attached_file :tile

  	validates_attachment_content_type :tile, :content_type => /^image\/(png|gif|jpeg)/

	private

		def create_name
			if name.blank?
				self.name = "Pattern No." + " #{position}"
			end
		end
end
