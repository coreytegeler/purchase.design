class Palette < ActiveRecord::Base

	scope :first_to_last, lambda {order("palettes.position ASC")}

	before_validation :add_hash_symbol

	validates :primary_color, :hex_color => true
	validates :secondary_color, :hex_color => true

	acts_as_list :order => :position

	private

		def add_hash_symbol
			if primary_color[0] != "#"
				primary_color[0,0] = "#"
			end

			if secondary_color[0] != "#"
				secondary_color[0,0] = "#"
			end
		end

end
