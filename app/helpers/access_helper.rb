module AccessHelper
	def admin?
		session[:admin_id]
	end

	def access?
        params[:controller] == 'access'
    end

    def errors_for(model)
        output_text = ""
        used_attributes = []
    	model.errors.each do |attribute, error|
            if !used_attributes.include? attribute
                used_attributes << attribute
                name = "#{attribute.to_s.humanize}"
                error = "#{error}"
                error_message = "<u>" + name + "</u> " + error + ". "
        		output_text << error_message.html_safe
            end
        end
        output_text
    end
end
