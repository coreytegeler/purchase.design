class Alumnus < ActiveRecord::Base

	scope :visible, lambda {where(:visible => true)}
	scope :invisible, lambda {where(:visible => false)}
	scope :first_to_last, lambda {order("alumni.position ASC")}
	scope :last_to_first, lambda {order("alumni.position DESC")}
	scope :new_to_old, lambda {order("alumni.created_at DESC")}
	scope :old_to_new, lambda {order("alumni.created_at ASC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}

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
	validates_presence_of :first_name, :last_name, :url

	acts_as_list :order => :position

   private

	def reposition
		Alumnus.first_to_last.each_with_index do |id, position|
			Alumnus.find(id).update_attribute(:position, position + 1)
		end
	end

	def format_url
		unless self.url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//]
    		self.url = "http://#{self.url}"
  		end
	end

end
