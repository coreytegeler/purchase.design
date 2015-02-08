module PeopleHelper
	def has_works(person)
		size = person.works.size
		if size > 0 
			text = ' has work!'
		else
			text = ' doesn\'t have any work. Sorry.'
		end
		content_tag(:span, person.name + text, :class => 'status false')

	end
end
