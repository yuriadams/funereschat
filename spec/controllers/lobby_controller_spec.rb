require 'rails_helper'

describe LobbyController do
  let!(:dialect){ Dialect.create(slug: "yoda") }
  let!(:room){ Room.create(name: "General") }
  let!(:user){ User.create(email: "yuriadams@gmail.com", dialect: dialect) }
  let(:text){ "Message xxxxxx" }
  let!(:message_1){ Message.create(text: text, user: user, room: room, created_at: DateTime.new(2017,3,2,0,4,0)) }
  let!(:message_2){ Message.create(text: text, user: user, room: room, created_at: DateTime.new(2017,3,2,0,5,0)) }
  let!(:message_3){ Message.create(text: text, user: user, room: room, created_at: DateTime.new(2017,3,2,0,6,0)) }

  before do
    session[:user_id] = user.id
  end

  describe "GET index" do
    subject{ get :index, params: { room_id: room.id } }
    
    it " renders index page" do
      subject
      expect(response).to render_template(:index)
    end

    it " returns all rooms" do
      subject
      expect(assigns(:rooms)).to eq([room])
    end

    it " returns the messages from a specific room" do
      subject
      expect(assigns(:messages).map{|m| [m.sender, m.time, m.text]}).to match_array([["yuriadams@gmail.com", "02/03/2017 00:04", "Message xxxxxx"],
                                                                                     ["yuriadams@gmail.com", "02/03/2017 00:05", "Message xxxxxx"],
                                                                                     ["yuriadams@gmail.com", "02/03/2017 00:06", "Message xxxxxx"]])
    end
  end
end
