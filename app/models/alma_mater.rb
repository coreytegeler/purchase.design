class AlmaMater < ActiveRecord::Base

    belongs_to :faculty
    scope :new_to_old, lambda {order("alma_maters.created_at DESC")}
    validates_presence_of :college, :degree

end
