require "rails_helper"

RSpec.describe Ranking, type: :model do
  describe "creation" do
    let!(:book) { create(:book) }
    let!(:user) { create(:user) }

    let(:creation_params) { {user: user, book: book, position: 1} }

    it "will succeed with valid parameters" do
      record = described_class.create(creation_params)
      expect(record).to be_valid
    end

    context "when there is no associated Book" do
      let(:record) { described_class.create(creation_params.except(:book)) }

      it "will fail with an appropriate error message" do
        expect(record.errors.full_messages).to include("Book must exist")
      end
    end

    context "when one already exists for the given Book and User" do
      let(:record) { described_class.create(creation_params.merge(position: 2)) }

      before { described_class.create(creation_params) }

      it "will fail with an appropriate error message" do
        expect(record.errors.full_messages).to include("Book has already been taken")
      end
    end

    context "when there is no associated User" do
      let(:record) { described_class.create(creation_params.except(:user)) }

      it "will fail with an appropriate error message" do
        expect(record.errors.full_messages).to include("User must exist")
      end
    end

    context "when validating position" do
      it "will fail when it is nil" do
        record = described_class.create(creation_params.merge(position: nil))

        expect(record.errors.full_messages).to include("Position can't be blank")
      end

      it "will fail when it is less than 0" do
        record = described_class.create(creation_params.merge(position: -1))

        expect(record.errors.full_messages).to include("Position must be greater than or equal to 0")
      end

      it "will fail when it is greater than 11" do
        record = described_class.create(creation_params.merge(position: 12))

        expect(record.errors.full_messages).to include("Position must be less than or equal to 11")
      end

      it "will fail when it is not an integer" do
        record = described_class.create(creation_params.merge(position: 5.5))

        expect(record.errors.full_messages).to include("Position must be an integer")
      end
    end
  end
end
