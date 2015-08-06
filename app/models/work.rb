class Work < ActiveRecord::Base
	
	scope :first_to_last, lambda {order("works.position ASC")}
	scope :last_to_first, lambda {order("works.position DESC")}

	has_attached_file :image,
	:styles => { 
		:small =>  ['300x300'],
		:medium => ['525x450']
	},
	:default_url => ActionController::Base.helpers.asset_path("image.svg")
		
  	validates_attachment_content_type :image, 
  		content_type: /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)/
  	validates_attachment_size :image, :less_than => 4.megabytes, 
                          :unless => Proc.new {|m| m[:image].nil?}

    has_attached_file :video,
    :styles => {
    	:mp4 => {
    		:geometry => "640x480",
    		:format => 'mp4',
    		:convert_options => {
    			:output => {:ar => 44100}
    		}
    	},
    	:thumb => {
    		:geometry => '300x300',
    		:format => 'jpg',
    		:time => 2
    	}
    },
    :processors => [:transcoder],
    :max_size => 300.megabytes
    # :storage => :s3,
    # :s3_credentials => S3_CREDENTIALS
  	
  	##here comes delayed video processing using delayed_papeclip
  	# process_in_background :source , :processing_image_url => "/images/loading.gif" 
    
    # validates_attachment_content_type :video, :content_type => ['video/mp4']
    before_validation :choose_content_type
    validate :content_type

    acts_as_list :order => :position

	   private

	    def choose_content_type
	    	if self.media_type == 'image'
	    		self.video = nil
	    	elsif self.media_type == 'video'
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
