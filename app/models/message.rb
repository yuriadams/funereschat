class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  def decorate
    MessageDecorator.new(self)
  end
end
