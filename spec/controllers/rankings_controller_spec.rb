require "rails_helper"

RSpec.describe RankingsController, type: :request do
  describe "#create" do
    let!(:book_one) { Book.create(title: "The Monk", author: "Matthew Lewis", published_at: Time.utc(1796), read_at: Time.utc(2021, 1), chosen_by: "Amy") }
    let!(:book_two) { Book.create(title: "Plum Rains", author: "Andromeda Romano-Lax", published_at: Time.utc(2018), read_at: Time.utc(2021, 2), chosen_by: "Scott") }
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

    context "when Rankings already exist for those books" do
      let(:book_three) { Book.create(title: "A Memory Called Empire", author: "Arkady Martine", published_at: Time.utc(2019), read_at: Time.utc(2021, 3), chosen_by: "Bruno") }
      let(:order) { [book_one.id, book_two.id, book_three.id] }

      before do
        Ranking.create!([{book: book_one, position: 1}, {book: book_two, position: 0}, {book: book_three, position: 2}])
      end

      it "overwrites them" do
        expect { make_request! }.not_to change(Ranking, :count)

        expect(Ranking.where(position: 0, book: book_one)).to exist
        expect(Ranking.where(position: 1, book: book_two)).to exist
        expect(Ranking.where(position: 2, book: book_three)).to exist
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
