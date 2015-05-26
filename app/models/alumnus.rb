class Alumnus < ActiveRecord::Base

	scope :first_to_last, lambda {order("alumni.position ASC")}

	acts_as_list scope: [:position]

	before_validation :reposition, :format_url

	has_attached_file :image, :styles => { 
		:small =>  ['300x300'],
		:medium => ['450x450'],
		:large =>  ['1200x1200>']
	}, 
	:default_url => "image.svg"
		
  	validates_attachment_content_type :image, 
  content_type: /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)/
	validates_presence_of :first_name, :last_name, :link, :image

	acts_as_list :order => :position

   private

	def reposition
		Alumnus.first_to_last.each_with_index do |id, position|
			Alumnus.find(id).update_attribute(:position, position + 1)
		end
	end

	def format_url
		if self.link.nil?
			unless self.link[/\Ahttp:\/\//] || self.link[/\Ahttps:\/\//]
	    		self.link = "http://#{self.link}"
	  		end
	  	end
	end

end
