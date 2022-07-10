require "rails_helper"

RSpec.describe Book, type: :model do
  describe "creation" do
    let(:creation_params) do
      {
        title: "The Left Hand of Darkness",
        author: "Ursula K. Le Guin",
        published_at: Time.utc(1969),
        read_at: Time.utc(2018, 3),
        chosen_by: "Susan"
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

    context "when the read date is nil" do
      let(:book) do
        described_class.create(creation_params.except(:read_at))
      end

      it "will fail with an appropriate error message" do
        expect(book.errors.full_messages).to include("Read at can't be blank")
      end
    end

    context "when the read date is blank" do
      let(:book) do
        described_class.create(creation_params.merge(read_at: ""))
      end

      it "will fail with an appropriate error message" do
        expect(book.errors.full_messages).to include("Read at can't be blank")
      end
    end

    context "when the read date is not unique" do
      let(:book) { described_class.create(creation_params) }
      let(:book_two) do
        described_class.create({
          title: "Kindred",
          author: "Octavia Butler",
          published_at: Time.zone.at(1979),
          read_at: book.read_at,
          chosen_by: "Rory"
        })
      end

      it "will fail with an appropriate error message" do
        expect(book_two.errors.full_messages).to include("Read at has already been taken")
      end
    end

    context "when the chooser is nil" do
      let(:book) do
        described_class.create(creation_params.except(:chosen_by))
      end

      it "will fail with an appropriate error message" do
        expect(book.errors.full_messages).to include("Chosen by can't be blank")
      end
    end

    context "when the chooser is blank" do
      let(:book) do
        described_class.create(creation_params.merge(chosen_by: ""))
      end

      it "will fail with an appropriate error message" do
        expect(book.errors.full_messages).to include("Chosen by can't be blank")
      end
    end
  end
end
