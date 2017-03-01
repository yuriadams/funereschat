class MessageChatJob < ApplicationJob
  queue_as :default

  def perform(room, user_id, text, dialect)
    translated_text = TranslatorService.translate(text, dialect)

    message = Message.create(room_id: room,
  													 user_id: user_id,
  													 text: translated_text)
                                                      
  	ActionCable.server.broadcast("chat_#{room}", message.decorate.to_json)
  end
end
