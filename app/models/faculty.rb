class Faculty < ActiveRecord::Base

	scope :visible, lambda {where(:visible => true)}
	scope :invisible, lambda {where(:visible => false)}
	scope :sorted, lambda {order("faculties.position ASC")}
	scope :a_to_z, lambda {order("faculties.name ASC")}
	scope :new_to_old, lambda {order("faculties.created_at DESC")}
	scope :old_to_new, lambda {order("faculties.created_at ASC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}

	acts_as_list scope: [:position]

	has_many :alma_maters
	accepts_nested_attributes_for :alma_maters, reject_if: proc { |attributes| attributes['college'].blank? }, :allow_destroy => true

	has_attached_file :image, :styles => { 
					  :thumb => ["200x200"], 
					  :medium => ["600x600>"], 
					  :large => ["1200x1200>"] }, 
					  :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :image, 
  content_type: /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)/

  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  	
  	validates_presence_of :first_name, :last_name
  	validates_format_of :email, :with => VALID_EMAIL_REGEX
	validates_confirmation_of :email
	validates_associated :alma_maters
end