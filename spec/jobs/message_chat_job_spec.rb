require 'rails_helper'

describe MessageChatJob do
  let(:room){ Room.create(name: "General") }
  let(:user){ User.create(email: "yuriadams@gmail.com") }
  let(:text){ 'GENERAL TEXT' }
  let(:dialect){ 'yoda' }

  it 'matches with enqueued job' do
    ActiveJob::Base.queue_adapter = :test

    expect {
      described_class.perform_later(room.id, user.id, text, dialect)
    }.to have_enqueued_job.with(room.id, user.id, text, dialect)
  end

  context "Internal Behaviour" do
    let(:message_hash) do
      { text: "GENERAL TEXT TRANSLATED",
        sender: "yuriadams@gmail.com",
        time: "02/03/2017 00:04" }
    end

    let(:action_server){ double('Server') }

    before do
      allow(TranslatorService).to receive(:translate) do
        "GENERAL TEXT TRANSLATED"
      end

      allow_any_instance_of(Message).to receive(:decorate){ message_hash }
      allow(ActionCable).to receive(:server){ action_server }
      allow(action_server).to receive(:broadcast)
    end

    it " broadcasts the message to room" do
      expect(action_server).to receive(:broadcast).with("chat_#{room.id}", message_hash.to_json)
      described_class.new.perform(room.id, user.id, text, dialect)
    end
  end
end
