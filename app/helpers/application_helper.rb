module ApplicationHelper
	def status(boolean)
		options={}
		options[:true_text] ||= "\u2714"
		options[:false_text] ||= "\u2718"

		if boolean
			content_tag(:span, options[:true_text], :class => 'status true')
		else
			content_tag(:span, options[:false_text], :class => 'status false')
		end
	end
end
