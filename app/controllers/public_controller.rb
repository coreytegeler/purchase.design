class PublicController < ApplicationController

	layout 'public'

	def index
		
	end

	def show 

	end

	def admin?
    	session[:admin_id]
  end

end
