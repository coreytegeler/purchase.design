class GroupPost < ActiveRecord::Base
	belongs_to :group
	belongs_to :post
end
