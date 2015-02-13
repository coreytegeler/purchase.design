class Admin < ActiveRecord::Base

	has_and_belongs_to_many :groups
	has_many :person_edits
	has_many :people, :through => :person_edits

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates_presence_of [:first_name, :last_name, :email, :username]
	validates_uniqueness_of [:email, :username]
	validates_format_of :email, :with => VALID_EMAIL_REGEX
	validates_confirmation_of [:email, :hashed_password]

	scope :sorted, lambda {order("admins.first_name ASC")}

end