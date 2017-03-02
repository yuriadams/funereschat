require 'rails_helper'

describe MessageDecorator do
  let(:dialect){ Dialect.create(name: "Yoda", slug: "yoda") }
  let(:room){ Room.create(name: "General") }
  let(:user){ User.create(email: "yuriadams@gmail.com") }
  let(:text){ "Message xxxxxx" }
  let(:message){ Message.create(text: text,
                                user: user,
                                room: room,
                                dialect: dialect.slug,
                                created_at: DateTime.new(2017,3,2,0,4,0)) }

  subject{ described_class.new(message) }

  describe '#text' do
    it "returns message's text" do
      expect(subject.text).to eq(text)
    end
  end

  describe '#sender' do
    it "returns user's email" do
      expect(subject.sender).to eq(user.email)
    end
  end

  describe '#time' do
    it "returns formatted created_at" do
      expect(subject.time).to eq('02/03/2017 00:04')
    end
  end

  describe '#to_json' do
    it "returns hash version from the decorator" do
      expect(subject.to_json).to eq({text: "Message xxxxxx",
                                     sender: "yuriadams@gmail.com",
                                     time: "02/03/2017 00:04",
                                     dialect: "yoda"})
    end
  end
end
