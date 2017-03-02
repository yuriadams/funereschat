class LobbyController < ApplicationController
	before_action :authenticate_user!

	def index
		@rooms 		= Room.all
		@messages = Message.includes(:user)
											 .where(room_id: params[:room_id])
											 .order(id: :asc)
											 .map(&:decorate)
	end
end
