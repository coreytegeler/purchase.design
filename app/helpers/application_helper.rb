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

	def error_messages_for(object)
		render(:partial => 'application/error_messages', :locals => {:object => object})
	end

end
