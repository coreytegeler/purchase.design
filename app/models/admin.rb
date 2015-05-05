class Admin < ActiveRecord::Base

	scope :a_to_z, lambda {order("admins.last_name ASC")}

	has_and_belongs_to_many :groups
	has_many :person_edits
	has_many :people, :through => :person_edits

	has_secure_password

	scope :sorted, lambda {order("admins.first_name ASC")}

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	FORBIDDEN_EMAIL = ['admin','root']

	validates_presence_of :first_name
	validates_presence_of :last_name
	validates_presence_of :email
	validates_uniqueness_of :email
	validates_format_of :email, :with => VALID_EMAIL_REGEX
	validates_confirmation_of :email
	validate :email_is_allowed

	def email_is_allowed
		if FORBIDDEN_EMAIL.include?(email)
			errors.add(:email, "has been restricted from use.")
		end
	end
end