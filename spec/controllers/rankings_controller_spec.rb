require "rails_helper"
require "support/shared_contexts/login"

RSpec.describe RankingsController, type: :request do
  describe "#create" do
    include_context "when logged in"

    let!(:book_one) { create(:book) }
    let!(:book_two) { create(:book) }
    let(:order) { [book_one.id, book_two.id] }

    let(:make_request!) do
      post "/rankings", params: {order: order}, as: :json
    end

    it "returns successfully" do
      make_request!
      expect(response).to be_successful
    end

    it "creates new Rankings" do
      expect { make_request! }.to change(Ranking, :count).by(2)

      expect(Ranking.where(position: 0, book: book_one)).to exist
      expect(Ranking.where(position: 1, book: book_two)).to exist
    end

    context "when the user does not have permission to update rankings" do
      include_context "when logged out"

      it "returns the 'Unauthorized' response code" do
        make_request!
        expect(response).to have_http_status(:unauthorized)
      end

      it "does not create any Rankings" do
        expect { make_request! }.not_to change(Ranking, :count)
      end
    end

    context "when Rankings already exist for those books" do
      let(:book_three) { create(:book) }
      let(:order) { [book_one.id, book_two.id, book_three.id] }

      context "when they belong to the same user" do
        before do
          Ranking.create!([
            {user: current_user, book: book_one, position: 1},
            {user: current_user, book: book_two, position: 0},
            {user: current_user, book: book_three, position: 2}
          ])
        end

        it "overwrites them" do
          expect { make_request! }.not_to change(Ranking, :count)

          expect(Ranking.where(user: current_user, position: 0, book: book_one)).to exist
          expect(Ranking.where(user: current_user, position: 1, book: book_two)).to exist
          expect(Ranking.where(user: current_user, position: 2, book: book_three)).to exist
        end
      end

      context "when they belong to a different user" do
        let!(:other_user) { create(:user) }

        before do
          Ranking.create!([
            {user: other_user, book: book_one, position: 1},
            {user: other_user, book: book_two, position: 0},
            {user: other_user, book: book_three, position: 2}
          ])
        end

        it "doesn't overwrite them" do
          make_request!

          expect(Ranking.where(user: other_user, position: 1, book: book_one)).to exist
          expect(Ranking.where(user: other_user, position: 0, book: book_two)).to exist
          expect(Ranking.where(user: other_user, position: 2, book: book_three)).to exist
        end

        it "creates new rankings" do
          expect { make_request! }.to change(Ranking, :count).by(3)

          expect(Ranking.where(user: current_user, position: 0, book: book_one)).to exist
          expect(Ranking.where(user: current_user, position: 1, book: book_two)).to exist
          expect(Ranking.where(user: current_user, position: 2, book: book_three)).to exist
        end
      end
    end

    context "with an overly long ordering" do
      let(:order) { (1..20).to_a }

      it "is unsuccessful" do
        make_request!
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "with a book that doesn't exist" do
      let(:order) { [-1, book_one.id] }

      it "is unsuccessful" do
        make_request!
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when the same book appears multiple times in one ordering" do
      let(:order) { [book_one.id, book_one.id] }

      it "is unsuccessful" do
        make_request!
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
