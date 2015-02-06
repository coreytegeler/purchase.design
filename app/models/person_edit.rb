class PersonEdit < ActiveRecord::Base
	belongs_to :admin
	belongs_to :person
end
