class MessageDecorator
  def initialize(message)
    @message = message
  end

  def text
    message.text
  end

  def sender
    message.user.email
  end

  def time
    message.created_at.strftime('%d/%m/%Y %H:%M')
  end

  def to_json
    {
      text: self.text,
      sender: self.sender,
      time: self.time
    }
  end

  private
    attr_reader :message
end
