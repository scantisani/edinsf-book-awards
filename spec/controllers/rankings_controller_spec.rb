require "rails_helper"

RSpec.describe RankingsController, type: :request do
  describe "#create" do
    context "with valid parameters" do
      let!(:book_one) { Book.create(title: "The Monk", author: "Matthew Lewis", published_at: Time.utc(1796), read_at: Time.utc(2021, 1), chosen_by: "Amy") }
      let!(:book_two) { Book.create(title: "Plum Rains", author: "Andromeda Romano-Lax", published_at: Time.utc(2018), read_at: Time.utc(2021, 2), chosen_by: "Scott") }

      let(:make_request!) do
        post "/rankings", params: {order: [book_one.id, book_two.id]}
      end

      it "returns successfully" do
        make_request!
        expect(response).to be_successful
      end
    end
  end
end
