class Work < ActiveRecord::Base
	scope :visible, lambda {where(:visible => true)}
	scope :invisible, lambda {where(:visible => false)}
	scope :first_to_last, lambda {order("works.position ASC")}
	scope :last_to_first, lambda {order("works.position DESC")}
	scope :new_to_old, lambda {order("works.created_at DESC")}
	scope :old_to_new, lambda {order("works.created_at ASC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}

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

    acts_as_list :order => :position
    validates_numericality_of :position, :only_integer => true , :allow_nil => false

    before_validation :reposition

	   private

		def reposition
			Work.first_to_last.each_with_index do |id, position|
				Work.find(id).update_attribute(:position, position + 1)
			end
		end
		
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
