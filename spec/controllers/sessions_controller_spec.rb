require 'rails_helper'

describe SessionsController do
  describe "POST create" do
    let!(:dialect){ Dialect.create(slug: "yoda") }
    let!(:user){ User.create(email: "yuriadams@gmail.com", dialect: dialect) }

    context " given a selected dialect" do
      subject{ post :create, params: { sessions: { email: user.email, dialect_slug: dialect.slug } } }

      it " updates the user with the dialect"

      it " includes user's id into session"

      it " redirects to lobby"

      it " presents success message"
    end

    context " given the user didn't select a dialect" do
      subject{ post :create, params: { sessions: { email: user.email } } }

      it " presents error message"

      it " redirects to root"
    end

  end

  describe "DELETE destroy" do
    subject{ delete :destroy }


  end
end
