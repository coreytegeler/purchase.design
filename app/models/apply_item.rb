class ApplyItem < ActiveRecord::Base

	scope :sorted, lambda {order("apply_items.position ASC")}
	scope :new_to_old, lambda {order("apply_items.created_at ASC")}

	acts_as_list scope: [:position]
	validates_presence_of :student, :parent

end
