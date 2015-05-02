module PublicHelper
	def randomm_logo
	  @image_files = %w( .svg )
	  @files ||= Dir.entries(
	    "#{Rails.root}/app/assets/images/logos").delete_if { |x|
	      !@image_files.index(x[-4,4])
	    }

	  file = @files[rand(@files.length)];
	  @files.delete file

	  return "logos/#{file}"
	end

	def color(*args)
    	arrays = args.each_slice(2).to_a
    	styles = 'style='
        
    	arrays.each do |pair|
    		prop = pair.first
    		val = pair.last
    		case prop
    		when 'border'
    			prop = 'border-color'
    		when 'bg'
    			prop = 'background-color'
    		when 'text'
    			prop = 'color'
    		end

    		style = prop + ':' + val + ';'
    		styles << style
    	end
    	styles
  	end

    def gradient
        
    end

    def public?
        params[:controller] == 'public'
    end
end
