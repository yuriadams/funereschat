class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected
  	def current_user
  		User.find_by(id: session[:user_id])
  	end

  	def authenticate_user!
  		current_user || redirect_to(root_url)
  	end
end
