require "rails_helper"

RSpec.describe BooksController, type: :request do
  describe "#index" do
    let!(:book_one) { Book.create(title: "The Monk", author: "Matthew Lewis", published_at: Time.utc(1796), read_at: Time.utc(2021, 1), chosen_by: "Amy") }
    let!(:book_two) { Book.create(title: "Plum Rains", author: "Andromeda Romano-Lax", published_at: Time.utc(2018), read_at: Time.utc(2021, 2), chosen_by: "Scott") }

    let(:expected_response) do
      [
        {"id" => book_one.id, "title" => book_one.title, "author" => book_one.author},
        {"id" => book_two.id, "title" => book_two.title, "author" => book_two.author}
      ]
    end

    it "returns the books as JSON with only a subset of fields, ordered by read date" do
      get "/books"

      parsed_body = JSON.parse(response.body)
      expect(parsed_body).to eq(expected_response)
    end

    context "when the books have associated rankings" do
      before do
        book_one.rankings.create(position: 1)
        book_two.rankings.create(position: 0)
      end

      it "orders the books by their ranking" do
        get "/books"

        ordered_ids = JSON.parse(response.body).pluck("id")
        expect(ordered_ids).to eq([book_two.id, book_one.id])
      end
    end
  end

  describe "when there are no books" do
    let(:book_one) { nil }
    let(:book_two) { nil }

    it "returns an empty array" do
      get "/books"

      expect(response.body).to eq("[]")
    end
  end
end
