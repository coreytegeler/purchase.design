class Course < ActiveRecord::Base

	scope :a_to_z, lambda {order("courses.name ASC")}
	scope :in_order, lambda {order("courses.position ASC")}

	acts_as_list scope: [:position]
	validates_presence_of :name

	has_many :course_images, :dependent => :destroy
	accepts_nested_attributes_for :course_images, reject_if: proc { |attributes| attributes['image'].blank? }, :allow_destroy => true

end
