class ApplyItem < ActiveRecord::Base

	scope :first_to_last, lambda {order("apply_items.position ASC")}

	validates_presence_of :text

    acts_as_list :order => :position

end
