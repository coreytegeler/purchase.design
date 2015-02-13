class Group < ActiveRecord::Base
  
	has_many :people
	has_and_belongs_to_many :admins
	has_and_belongs_to_many :posts

	validates_presence_of :name
	validates_uniqueness_of :slug

	scope :visible, lambda {where(:visible => true)}
	scope :invisible, lambda {where(:visible => false)}
	scope :sorted, lambda {order("groups.position ASC")}
	scope :newest_first, lambda {order("groups.created_at ASC")}
	scope :oldest_first, lambda {order("groups.created_at DESC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}

end
