class MessageChatJob < ApplicationJob
  queue_as :default

  def perform(room_id, user_id, text)
    user = User.find(user_id)
    translated_text = TranslatorService.translate(text, user.dialect.slug)

    message = Message.create(room_id: room_id,
                             user_id: user.id,
                             dialect: user.dialect.slug,
                             text: translated_text)

    ActionCable.server.broadcast("chat_#{room_id}", message.decorate.to_json)
  end
end
