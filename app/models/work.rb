class Work < ActiveRecord::Base

	scope :visible, lambda {where(:visible => true)}
	scope :invisible, lambda {where(:visible => false)}
	scope :sorted, lambda {order("works.position ASC")}
	scope :new_to_old, lambda {order("works.created_at DESC")}
	scope :old_to_new, lambda {order("works.created_at ASC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}

	acts_as_list scope: [:position]

	has_attached_file :image, :styles => { 
		:thumb => ["200x200"],
		:small => ["400x400"],
		:medium => ["600x600>"], # 450!
		:large => ["1200x1200>"] }, 
		:default_url => "/images/:style/missing.png"
		
  	validates_attachment_content_type :image, 
  content_type: /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)/

    has_attached_file :motion, :styles => {
            :medium => { :geometry => "640x480", :format => 'mp4'},
            :thumb => {:geometry => "100x100#", :format => 'jpg', :time => 10}
        }, :processors => [:ffmpeg]

    validates_attachment_content_type :motion, content_type: /\Avideo\/.*\Z/ 

    validate :get_dimensions, :unless => "errors.any?"

    private
		
		def get_dimensions
		  dimensions = Paperclip::Geometry.from_file(image.queued_for_write[:original].path)
		  if dimensions.width > dimensions.height
		  	self.orientation = 'landscape'
		  elsif dimensions.width < dimensions.height
		  	self.orientation = 'portrait'
		  else
		  	self.orientation = 'square'
		  end
		end

end
