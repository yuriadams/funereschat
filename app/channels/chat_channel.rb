class ChatChannel < ApplicationCable::Channel
	def subscribed
		stream_from "chat_#{params[:room]}"
  end

  def receive(data)
  	message = Message.create(room_id: params[:room],
  													 user_id: params[:user],
  													 text: data['text'])

  	ActionCable.server.broadcast("chat_#{params[:room]}", message)
  end
end
