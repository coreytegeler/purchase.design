class AlmaMater < ActiveRecord::Base

    belongs_to :faculty
    validates_presence_of :faculty_id, :college, :degree, :year

end
