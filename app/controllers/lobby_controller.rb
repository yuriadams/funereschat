class LobbyController < ApplicationController
	def index
		@rooms 		= Room.all
		@messages = Message.where(room_id: params[:room_id])
	end
end
