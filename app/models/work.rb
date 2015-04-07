class Work < ActiveRecord::Base

	scope :visible, lambda {where(:visible => true)}
	scope :invisible, lambda {where(:visible => false)}
	scope :sorted, lambda {order("works.position ASC")}
	scope :newest_first, lambda {order("works.created_at ASC")}
	scope :oldest_first, lambda {order("works.created_at DESC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}

	acts_as_list scope: [:position]

	has_attached_file :image, :styles => { 
		:thumb => ["200x200"], 
		:medium => ["600x600>"], 
		:large => ["1200x1200>"] }, 
		:default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :image, 
  content_type: /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)/

    has_attached_file :motion, :styles => {
            :medium => { :geometry => "640x480", :format => 'mp4'},
            :thumb => {:geometry => "100x100#", :format => 'jpg', :time => 10}
        }, :processors => [:ffmpeg]

    validates_attachment_content_type :motion, content_type: /\Avideo\/.*\Z/ 

end
