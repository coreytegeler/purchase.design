class EventImage < ActiveRecord::Base

	scope :visible, lambda {where(:visible => true)}
	scope :invisible, lambda {where(:visible => false)}
	scope :sorted, lambda {order("events.position ASC")}

	acts_as_list scope: [:position]

	has_attached_file :image, :styles => { 
		:thumb => ["200x200"], 
		:medium => ["600x600>"], 
		:large => ["1200x1200>"] }, 
		:default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :image, 
  		content_type: /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)/
    validates_attachment_presence :image

    belongs_to :event

end
