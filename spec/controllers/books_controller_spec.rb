require "rails_helper"

RSpec.describe BooksController, type: :request do
  describe "#index" do
    describe "when there are no books" do
      it "returns an empty array" do
        get "/books"

        expect(response.body).to eq("[]")
      end
    end

    describe "when there are books" do
      let!(:book_one) { Book.create(title: "The Monk", author: "Matthew Lewis", published_at: Time.utc(1796), read_at: Time.utc(2021, 1), chosen_by: "Amy") }
      let!(:book_two) { Book.create(title: "Plum Rains", author: "Andromeda Romano-Lax", published_at: Time.utc(2018), read_at: Time.utc(2021, 2), chosen_by: "Scott") }

      let(:expected_response) do
        [
          {"id" => book_one.id, "title" => book_one.title, "author" => book_one.author},
          {"id" => book_two.id, "title" => book_two.title, "author" => book_two.author}
        ]
      end

      it "returns the books as JSON with only a subset of fields" do
        get "/books"

        parsed_body = JSON.parse(response.body)
        expect(parsed_body).to eq(expected_response)
      end
    end
  end
end
