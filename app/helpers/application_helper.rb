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

	def to_slug
		#strip the string
		ret = self.strip

		#blow away apostrophes
		ret.gsub! /['`]/,""

		# @ --> at, and & --> and
		ret.gsub! /\s*@\s*/, " at "
		ret.gsub! /\s*&\s*/, " and "

		#replace all non alphanumeric, underscore or periods with underscore
		 ret.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '_'  

		 #convert double underscores to single
		 ret.gsub! /_+/,"_"

		 #strip off leading/trailing underscore
		 ret.gsub! /\A[_\.]+|[_\.]+\z/,""

		 ret
  	end

  	def this_year
  		Time.now.year
  	end

  	def pluralize_without_count(count, noun, text = nil)
	  if count != 0
	    count == 1 ? "#{noun}#{text}" : "#{noun.pluralize}#{text}"
	  end
	end

	def inline_svg(file, in_db)
		if in_db == true
        	Paperclip.io_adapters.for(file).read.html_safe
        else
  			svg = File.open("app/assets/images/#{file}", "rb")
  			raw svg.read
        end
    end

end
