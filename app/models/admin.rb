class Admin < ActiveRecord::Base

	has_and_belongs_to_many :groups
	has_many :person_edits
	has_many :people, :through => :person_edits

end