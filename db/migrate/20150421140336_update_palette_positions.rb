class UpdatePalettePositions < ActiveRecord::Migration
	def up
		Palette.all.each_with_index do |p, i|
	    	p.update_attribute(:position, i)
		end
	end
end
