class Student < ActiveRecord::Base
	
	scope :visible, lambda {where(:visible => true)}
	scope :invisible, lambda {where(:visible => false)}
	scope :sorted, lambda {order("students.position ASC")}
	scope :newest_first, lambda {order("students.created_at ASC")}
	scope :oldest_first, lambda {order("students.created_at DESC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}
end
