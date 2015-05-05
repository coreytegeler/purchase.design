class Post < ActiveRecord::Base

	scope :visible, lambda {where(:visible => true)}
	scope :invisible, lambda {where(:visible => false)}
	scope :sorted, lambda {order("posts.position ASC")}
	scope :new_to_old, lambda {order("posts.created_at DESC")}
	scope :old_to_new, lambda {order("posts.created_at ASC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}

	acts_as_list scope: [:position]
  	validates_presence_of :title

  	has_many :post_images, :dependent => :destroy
	accepts_nested_attributes_for :post_images, reject_if: proc { |attributes| attributes['image'].blank? }, :allow_destroy => true

end