module AccessHelper
	def admin?
		session[:admin_id]
	end
end
