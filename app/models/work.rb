class Work < ActiveRecord::Base
	scope :first_to_last, lambda {order("works.position ASC")}
	scope :last_to_first, lambda {order("works.position DESC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}

	has_attached_file :image,
	:styles => { 
		:small =>  ['300x300'],
		:medium => ['450x450'],
		:large =>  ['1200x1200>']
	},
	# :convert_options => {
	# 	:small =>  ['-set colorspace sRGB -strip'],
	# 	:medium => ['-set colorspace sRGB -strip'],
	# 	:large =>  ['-set colorspace sRGB -strip -sharpen 0x0.5']
	# },
	:default_url => "image.svg"
		
  	validates_attachment_content_type :image, 
  content_type: /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)/

    has_attached_file :video, :styles => {
            :medium => { :geometry => "600x450", :format => 'mp4'},
            :thumb => {:geometry => "300x300#", :format => 'jpg', :time => 10}
        }, :processors => [:ffmpeg]

    validates_attachment_content_type :video, content_type: /\Avideo\/.*\Z/ 

    before_validation :choose_content_type
    validate :content_type

    acts_as_list :order => :position

	   private

	    def choose_content_type
	    	if self.media_type == 'image'
	    		self.video = nil
	    	else 
	    		self.image = nil
	    	end
	    end

		def content_type
			if image.blank? and video.blank?
				return false
			elsif !image.blank? and !video.blank?
				return false
			else
				return true
			end
		end

end
