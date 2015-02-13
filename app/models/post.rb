class Post < ActiveRecord::Base

	has_and_belongs_to_many :groups

	CONTENT_TYPES = ['text', 'HTML']

	validates_uniqueness_of :slug
	validates_inclusion_of :content_type, :in => CONTENT_TYPES, :message => "must be #{CONTENT_TYPES.join(' or ')}"
	validates_presence_of [:title, :content]

	scope :visible, lambda {where(:visible => true)}
	scope :invisible, lambda {where(:visible => false)}
	scope :sorted, lambda {order("posts.position ASC")}
	scope :newest_first, lambda {order("posts.created_at ASC")}
	scope :oldest_first, lambda {order("posts.created_at DESC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}

end
