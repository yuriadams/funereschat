class LobbyController < ApplicationController
	def index
		@rooms 		= Room.all
		@messages = Message.includes(:user)
											 .where(room_id: params[:room_id])
											 .map(&:decorate)
	end
end
