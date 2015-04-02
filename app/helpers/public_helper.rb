module PublicHelper
	def random_logo
	  @image_files = %w( .svg )
	  @files ||= Dir.entries(
	    "#{Rails.root}/app/assets/images/logos").delete_if { |x|
	      !@image_files.index(x[-4,4])
	    }

	  file = @files[rand(@files.length)];
	  @files.delete file

	  return "assets/logos/#{file}"
	end
end
