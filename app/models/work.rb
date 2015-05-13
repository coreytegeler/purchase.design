class Work < ActiveRecord::Base

	scope :visible, lambda {where(:visible => true)}
	scope :invisible, lambda {where(:visible => false)}
	scope :sorted, lambda {order("works.position DESC")}
	scope :new_to_old, lambda {order("works.created_at DESC")}
	scope :old_to_new, lambda {order("works.created_at ASC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}

	acts_as_list scope: [:position]

	has_attached_file :image, :styles => { 
		:small => ["300x300"],
		:medium => ["450x450"],
		:large => ["1200x1200>"] }, 
		:default_url => "image.svg"
		
  	validates_attachment_content_type :image, 
  content_type: /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)/

    has_attached_file :video, :styles => {
            :medium => { :geometry => "600x450", :format => 'mp4'},
            :thumb => {:geometry => "300x300#", :format => 'jpg', :time => 10}
        }, :processors => [:ffmpeg]

    validates_attachment_content_type :video, content_type: /\Avideo\/.*\Z/ 

    validate :content_type

    # validate :get_dimensions, :unless => "errors.any?"

	   private
		
		# def get_dimensions
		#   dimensions = Paperclip::Geometry.from_file(image.queued_for_write[:original].path)
		#   if dimensions.width > dimensions.height
		#   	self.orientation = 'landscape'
		#   elsif dimensions.width < dimensions.height
		#   	self.orientation = 'portrait'
		#   else
		#   	self.orientation = 'square'
		#   end
		# end

		def content_type
		  if image.blank? and video.blank?
		   #one at least must be filled in, add a custom error message
		   return false
		  elsif !image.blank? and !video.blank?
		   #both can't be filled in, add custom error message
		   return false
		  else
		   return true
		  end
		end

end
