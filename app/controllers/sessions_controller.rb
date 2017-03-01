class SessionsController < ApplicationController
	def create
		user 		= User.find_or_initialize_by(email: params[:sessions][:email])
		dialect = Dialect.find_by(slug: params[:sessions][:dialect_slug])

		if user.update(dialect: dialect)
			flash[:notice] = "Success!"
			session[:user_id] = user.id
			redirect_to lobby_index_path
		else
			flash[:error] = user.errors.full_messages
			redirect_to root_path
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "Logout with success."
		redirect_to root_path
	end
end
