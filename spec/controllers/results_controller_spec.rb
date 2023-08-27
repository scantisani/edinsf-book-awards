require "rails_helper"
require "support/shared_contexts/login"

RSpec.describe ResultsController, type: :request do
  describe "#index" do
    include_context "when logged in"

    let!(:book_one) { create(:book) }
    let!(:book_two) { create(:book) }

    let(:expected_response) do
      [
        {"id" => book_one.id, "title" => book_one.title, "author" => book_one.author},
        {"id" => book_two.id, "title" => book_two.title, "author" => book_two.author}
      ]
    end

    it "returns the books as JSON with only a subset of fields, ordered by read date" do
      get results_path

      parsed_body = JSON.parse(response.body)
      expect(parsed_body).to eq(expected_response)
    end

    context "when the user does not have permission to view the books" do
      include_context "when logged out"

      it "returns the 'Unauthorized' response code" do
        get results_path

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "when there are no books" do
      let(:book_one) { nil }
      let(:book_two) { nil }

      it "returns an empty array" do
        get results_path
        expect(response.body).to eq("[]")
      end
    end
  end
end
