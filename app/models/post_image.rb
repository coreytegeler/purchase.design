class PostImage < ActiveRecord::Base

    belongs_to :post
    scope :sorted, lambda {order("post_images.position ASC")}

    has_attached_file :image, :styles => { 
		:thumb => ["200x200"],
		:small => ["400x400"],
		:medium => ["600x600>"], 
		:large => ["1200x1200>"] }, 
		:default_url => "/images/:style/missing.png"
		
  	validates_attachment_content_type :image, 
  content_type: /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)/

    validates_presence_of :image, :post_id

end
