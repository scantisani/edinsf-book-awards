require "rails_helper"

RSpec.describe UsersController, type: :request do
  let!(:user) { User.create(name: "Scott") }

  describe "#show" do
    context "when the UUID is valid" do
      before { get user_path(user.uuid) }

      it "redirects to the root path" do
        expect(response).to redirect_to(root_url)
      end

      it "sets the session cookie to the user's ID" do
        expect(session[:user_id]).to eq(user.id)
      end
    end

    context "when the user is already logged in" do
      let!(:user_two) { User.create(name: "Tony") }

      before { get user_path(user.uuid) }

      it "overwrites the user ID in the session cookie" do
        get user_path(user_two.uuid)
        expect(session[:user_id]).to eq(user_two.id)
      end
    end

    context "when the UUID is invalid" do
      before { get user_path(SecureRandom.uuid) }

      it "returns a 404" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
