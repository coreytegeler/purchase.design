class ApplyItem < ActiveRecord::Base

	scope :sorted, lambda {order("apply_items.position ASC")}
	scope :newest_first, lambda {order("apply_items.created_at ASC")}

	acts_as_list scope: [:position]

end
