require "rails_helper"

RSpec.describe Book, type: :model do
  describe "creation" do
    let(:creation_params) do
      {
        title: "The Left Hand of Darkness",
        author: "Ursula K. Le Guin",
        published_at: Time.zone.at(1969)
      }
    end

    context "when the title is nil" do
      let(:book) do
        described_class.create(creation_params.except(:title))
      end

      it "will fail with an appropriate error message" do
        expect(book.errors.full_messages).to include("Title can't be blank")
      end
    end

    context "when the title is blank" do
      let(:book) do
        described_class.create(creation_params.merge(title: ""))
      end

      it "will fail with an appropriate error message" do
        expect(book.errors.full_messages).to include("Title can't be blank")
      end
    end

    context "when the author is nil" do
      let(:book) do
        described_class.create(creation_params.except(:author))
      end

      it "will fail with an appropriate error message" do
        expect(book.errors.full_messages).to include("Author can't be blank")
      end
    end

    context "when the author is blank" do
      let(:book) do
        described_class.create(creation_params.merge(author: ""))
      end

      it "will fail with an appropriate error message" do
        expect(book.errors.full_messages).to include("Author can't be blank")
        expect(book)
      end
    end

    context "when the publication date is nil" do
      let(:book) do
        described_class.create(creation_params.except(:published_at))
      end

      it "will fail with an appropriate error message" do
        expect(book.errors.full_messages).to include("Published at can't be blank")
      end
    end

    context "when the publication date is blank" do
      let(:book) do
        described_class.create(creation_params.merge(published_at: ""))
      end

      it "will fail with an appropriate error message" do
        expect(book.errors.full_messages).to include("Published at can't be blank")
      end
    end
  end
end
