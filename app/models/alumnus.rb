class Alumnus < ActiveRecord::Base

	scope :visible, lambda {where(:visible => true)}
	scope :invisible, lambda {where(:visible => false)}
	scope :sorted, lambda {order("alumni.position ASC")}
	scope :newest_first, lambda {order("alumni.created_at ASC")}
	scope :oldest_first, lambda {order("alumni.created_at DESC")}
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
