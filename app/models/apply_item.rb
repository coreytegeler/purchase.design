class ApplyItem < ActiveRecord::Base

	scope :first_to_last, lambda {order("apply_items.position ASC")}
	scope :last_to_first, lambda {order("apply_items.position DESC")}

	validates_presence_of :student, :parent

    acts_as_list :order => :position

end
