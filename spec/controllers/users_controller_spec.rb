require "rails_helper"

RSpec.describe UsersController, type: :request do
  let!(:user) { User.create(name: "Scott") }

  describe "#show" do
    context "when the UUID is valid" do
      before { get user_path(user.uuid) }

      it "redirects to the root path" do
        expect(response).to redirect_to(root_url)
      end

      it "sets the user ID in the session cookie" do
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
      let(:make_request!) { get user_path(SecureRandom.uuid) }

      it "returns a 404" do
        make_request!
        expect(response).to have_http_status(:not_found)
      end

      it "does not set the user ID in the session cookie" do
        make_request!
        expect(session[:user_id]).to be_nil
      end

      context "when the user is already logged in" do
        before { get user_path(user.uuid) }

        it "removes the user ID in the session cookie" do
          expect { make_request! }.to change { session[:user_id] }.from(user.id).to(nil)
        end
      end
    end
  end
end
