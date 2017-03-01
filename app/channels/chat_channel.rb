class ChatChannel < ApplicationCable::Channel
	def subscribed
		stream_from "chat_#{params[:room]}"
  end

  def receive(data)
  	MessageChatJob.perform_later(params[:room], params[:user], data['text'], "yoda")
  end
end
