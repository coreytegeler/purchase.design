class Palette < ActiveRecord::Base

	scope :sorted, lambda {order("palettes.position DESC")}
	acts_as_list scope: [:position]

	before_validation :create_position
	before_validation :create_name
	before_validation :add_hash_symbol

	validates :primary_color, :hex_color => true
	validates :secondary_color, :hex_color => true

	
	#before_validation :hexify

	private

	def create_position
		if position.blank?
			self.position = Palette.count + 1
		end
	end

	def create_name
		if name.blank?
			self.name = "Palette No." + " #{position}"
		end
	end

	def add_hash_symbol
		if primary_color[0] != "#"
			primary_color.insert(0, "#")
		end

		if secondary_color[0] != "#"
			secondary_color.insert(0, "#")
		end
	end

end
