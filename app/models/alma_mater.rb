class AlmaMater < ActiveRecord::Base

    belongs_to :faculty
    scope :new_to_old, lambda {order("alma_maters.created_at DESC")}
    validates_presence_of :college, :degree, :link
    before_validation :format_url

	private

	def format_url
		unless self.link[/\Ahttp:\/\//] || self.link[/\Ahttps:\/\//]
    		self.link = "http://#{self.link}"
  		end
	end

end
