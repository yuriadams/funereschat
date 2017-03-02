require 'rails_helper'

describe SessionsController do
  describe "DELETE destroy" do
    subject{ delete :destroy, params: { id: 1 } }

    it " redirects to root" do
      expect(subject).to redirect_to(root_path)
    end

    it " presents success message" do
      subject
      expect(flash['notice']).to eq "Logout with success."
    end

    it " removes user's id into session" do
      subject
      expect(session[:user_id]).to eq(nil)
    end
  end

  describe "POST create" do
    let!(:dialect){ Dialect.create(slug: "yoda") }
    let!(:dialect_2){ Dialect.create(slug: "pirate") }
    let!(:user){ User.create(email: "yuriadams@gmail.com", dialect: dialect) }

    context " given a selected dialect" do
      subject{ post :create, params: { sessions: { email: user.email, dialect_slug: dialect_2.slug } } }

      it " updates the user with the dialect" do
        subject
        expect(user.reload.dialect.slug).to eq('pirate')
      end

      it " includes user's id into session" do
        subject
        expect(session[:user_id]).to eq(user.id)
      end

      it " redirects to lobby" do
        expect(subject).to redirect_to(lobby_index_path)
      end

      it " presents success message" do
        subject
        expect(flash['notice']).to eq 'Success!'
      end
    end

    context " given the user didn't select a dialect" do
      subject{ post :create, params: { sessions: { email: user.email } } }

      it " presents error message" do
        subject
        expect(flash['error']).to eq ["Dialect must exist"]
      end

      it " redirects to root" do
        expect(subject).to redirect_to(root_path)
      end
    end
  end
end
