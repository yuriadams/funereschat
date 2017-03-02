class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:room_id]}"
    ChatConnections.add(params[:user_id].to_s)
    ActionCable.server.broadcast("active_connections", active_emails)
  end

  def unsubscribed
    ChatConnections.remove(params[:user_id].to_s)
    ActionCable.server.broadcast("active_connections", active_emails)
  end

  def receive(data)
    MessageChatJob.perform_later(params[:room_id], params[:user_id], data['text'])
  end

  private
      def active_emails
          User.where(id: ChatConnections.all).pluck(:id, :email)
      end

end
