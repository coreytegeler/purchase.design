class Course < ActiveRecord::Base

	scope :a_to_z, lambda {order("courses.name ASC")}

	acts_as_list scope: [:position]

	validates_presence_of :name
end
