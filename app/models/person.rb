class Person < ActiveRecord::Base

	belongs_to :group
	has_many :person_edits
	has_many :works
	has_many :admins, :through => :person_edits

	scope :visible, lambda {where(:visible => true)}
	scope :invisible, lambda {where(:visible => false)}
	scope :sorted, lambda {order("people.position ASC")}
	scope :newest_first, lambda {order("people.created_at ASC")}
	scope :oldest_first, lambda {order("people.created_at DESC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}
end
