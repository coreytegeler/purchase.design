class Alumnus < ActiveRecord::Base

	scope :visible, lambda {where(:visible => true)}
	scope :invisible, lambda {where(:visible => false)}
	scope :sorted, lambda {order("alumni.position ASC")}
	scope :new_to_old, lambda {order("alumni.created_at DESC")}
	scope :old_to_new, lambda {order("alumni.created_at ASC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}

	acts_as_list scope: [:position]

	before_validation :format_url

	private

	def format_url
		unless self.url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//]
    		self.url = "http://#{self.url}"
  		end
	end

end
