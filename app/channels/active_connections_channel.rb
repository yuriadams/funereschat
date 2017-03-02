class ActiveConnectionsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "active_connections"
  end
end
