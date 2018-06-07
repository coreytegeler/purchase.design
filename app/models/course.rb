class Course < ActiveRecord::Base

	scope :a_to_z, lambda {order("courses.name ASC")}

	acts_as_list scope: [:position]

	has_many :course_images, :dependent => :destroy

	validates_presence_of :name
	accepts_nested_attributes_for :course_images, reject_if: proc { |attributes| attributes['image'].blank? }, :allow_destroy => true

end
