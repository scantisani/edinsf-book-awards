require "rails_helper"

RSpec.describe Book, type: :model do
  let(:creation_params) do
    {
      title: "The Left Hand of Darkness",
      author: "Ursula K. Le Guin",
      published_at: Time.utc(1969),
      read_at: Time.utc(2018, 3),
      chosen_by: "Susan"
    }
  end

  describe "creation" do
    context "when validating title" do
      it "will fail when it is nil" do
        record = described_class.create(creation_params.except(:title))
        expect(record.errors.full_messages).to include("Title can't be blank")
      end

      it "will fail when it is blank" do
        record = described_class.create(creation_params.merge(title: ""))
        expect(record.errors.full_messages).to include("Title can't be blank")
      end
    end

    context "when validating author" do
      it "will fail when it is nil" do
        record = described_class.create(creation_params.except(:author))
        expect(record.errors.full_messages).to include("Author can't be blank")
      end

      it "will fail when it is blank" do
        record = described_class.create(creation_params.merge(author: ""))
        expect(record.errors.full_messages).to include("Author can't be blank")
      end
    end

    context "when validating publication date" do
      it "will fail when it is nil" do
        record = described_class.create(creation_params.except(:published_at))
        expect(record.errors.full_messages).to include("Published at can't be blank")
      end

      it "will fail when it is blank" do
        record = described_class.create(creation_params.merge(published_at: ""))
        expect(record.errors.full_messages).to include("Published at can't be blank")
      end
    end

    context "when validating read date" do
      it "will fail when it is nil" do
        record = described_class.create(creation_params.except(:read_at))
        expect(record.errors.full_messages).to include("Read at can't be blank")
      end

      it "will fail when it is blank" do
        record = described_class.create(creation_params.merge(read_at: ""))
        expect(record.errors.full_messages).to include("Read at can't be blank")
      end

      it "will fail when it is not unique" do
        record = described_class.create(creation_params)
        record_two = described_class.create(
          title: "Kindred", author: "Octavia Butler", published_at: Time.zone.at(1979),
          read_at: record.read_at, chosen_by: "Rory"
        )

        expect(record_two.errors.full_messages).to include("Read at has already been taken")
      end
    end

    context "when validating chooser" do
      it "will fail when it is blank" do
        record = described_class.create(creation_params.merge(chosen_by: ""))
        expect(record.errors.full_messages).to include("Chosen by can't be blank")
      end
    end

    context "when the chooser is nil" do
      it "will have the default value 'Unknown'" do
        record = described_class.create(creation_params.except(:chosen_by))
        expect(record.chosen_by).to eq("Unknown")
      end
    end
  end

  describe "deletion" do
    it "removes all associated rankings" do
      record = described_class.create(creation_params)
      ranking = record.rankings.create(position: 0)

      record.destroy
      expect(ranking).not_to be_persisted
    end
  end
end
