class Work < ActiveRecord::Base
	belongs_to :person

	scope :visible, lambda {where(:visible => true)}
	scope :invisible, lambda {where(:visible => false)}
	scope :sorted, lambda {order("works.position ASC")}
	scope :newest_first, lambda {order("works.created_at ASC")}
	scope :oldest_first, lambda {order("works.created_at DESC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}
end