module SessionHelper
	def user_signed_in?
		current_user.present?
	end

	def current_user
		User.find_by(id: session[:user_id])
	end
end
