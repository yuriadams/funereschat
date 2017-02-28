class ChatChannel < ApplicationCable::Channel
	def subscribed
		stream_from "chat_#{params[:room]}"
  end

  def receive(data)
  	MessageChatJob.perform_async(params[:room], params[:user], data['text'], 1)
  end
end
