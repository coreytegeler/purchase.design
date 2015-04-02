class Event < ActiveRecord::Base

	scope :visible, lambda {where(:visible => true)}
	scope :invisible, lambda {where(:visible => false)}
	scope :sorted, lambda {order("events.position ASC")}
	scope :newest_first, lambda {order("events.created_at ASC")}
	scope :oldest_first, lambda {order("events.created_at DESC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}

	acts_as_list scope: [:position]

    has_many :event_images, :dependent => :destroy
	accepts_nested_attributes_for :event_images, :reject_if => lambda { |t| t['event_image'].blank? }, :allow_destroy => true

end
