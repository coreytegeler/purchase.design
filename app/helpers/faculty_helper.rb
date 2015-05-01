module FacultyHelper
	def sentencize(size, index)
		if size > 1
			if index == size - 1
				'. '
			elsif index != size - 2
				', '
			else
				' and '
			end
		else
			'.'
		end
			
	end
end
