class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	 def has_admin_privileges?
		# unless current_user
		# 	redirect_to "/users/sign_in" and return
		# end

		# unless current_user.admin
		# 	render(file: "public/403.html", status: "403.html") and return
		# end
		# true

		redirect_to "/users/sign_in" unless current_user
		render_403 unless current_user.admin
	end

	def render_403
		render(file: "public/403.html", status: "403.html")
	end


end
