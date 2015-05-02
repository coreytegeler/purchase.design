module AccessHelper
	def admin?
		session[:admin_id]
	end

	def access?
        params[:controller] == 'access'
    end
end
