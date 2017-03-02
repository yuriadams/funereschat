class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:room_id]}"

		ChatConnections.add(params[:user_id].to_s)

		emails = ChatConnections.all.map do |user_id|
			User.find_by(id: user_id).try(:email)
		end

		ActionCable.server.broadcast("active_connections", emails)
  end

	def unsubscribed
  	ChatConnections.remove(params[:user_id].to_s)
	end

  def receive(data)
    MessageChatJob.perform_later(params[:room_id], params[:user_id], data['text'])
  end
end
