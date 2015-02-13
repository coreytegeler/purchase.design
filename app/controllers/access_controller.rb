class AccessController < ApplicationController
  def index

  end

  def login

  end

  def attempt_login 
  	if params[:username].present? && params[:password].present?
  		found_user = Admin.where(:username => params[:username]).first
  		if found_user
  			authorized_user = found_user.authenticate(params[:password])
  		end
  	end
  	if authorized_user
  		
  		flash[:notice] = "You're in!"
  		flash[:type] = "good"
  		redirect_to(:action => 'index')
  	else
  		flash[:notice] = "Wrong login info!"
  		flash[:type] = "bad"
  		redirect_to(:action => 'login')
  	end
  end

  def logout
  	flash[:notice] = "Bye bye"
  	flash[:type] = "good"
  	redirect_to(:action => 'login')
  end
end
