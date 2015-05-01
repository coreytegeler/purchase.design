class Palette < ActiveRecord::Base

	scope :sorted, lambda {order("palettes.position DESC")}
	scope :new_to_old, lambda {order("palettes.created_at DESC")}
	scope :old_to_new, lambda {order("palettes.created_at ASC")}

	acts_as_list scope: [:position]

	before_validation :create_name
	before_validation :add_hash_symbol

	validates :primary_color, :hex_color => true
	validates :secondary_color, :hex_color => true

	private

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
