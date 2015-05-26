class Post < ActiveRecord::Base

	scope :new_to_old, lambda {order("posts.created_at DESC")}

	acts_as_list scope: [:position]
  	validates_presence_of :title

  	has_many :post_images, :dependent => :destroy
	accepts_nested_attributes_for :post_images, reject_if: proc { |attributes| attributes['image'].blank? }, :allow_destroy => true

end