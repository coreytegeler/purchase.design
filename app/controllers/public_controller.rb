class PublicController < ApplicationController

	layout 'public'

	def admin?
    	session[:admin_id]
  end

end
