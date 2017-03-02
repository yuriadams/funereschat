class ChatChannel < ApplicationCable::Channel
    def subscribed
        stream_from "chat_#{params[:room_id]}"
  end

  def receive(data)
      MessageChatJob.perform_later(params[:room_id], params[:user_id], data['text'])
  end
end
