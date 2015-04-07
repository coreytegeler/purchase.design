class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index 
  	@groups = Group.sorted
  	@posts = Post.sorted
  end

  def logged_in?
  	!!session[:admin_id]
  end

  def confirm_logged_in
    unless session[:admin_id]
      flash[:notice] = "You are not logged in"
      redirect_to(:controller => 'access', :action => 'login')
      return false
    else
      return true
    end
  end

end
