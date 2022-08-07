require "rails_helper"

RSpec.describe User, type: :model do
  describe "creation" do
    let(:user) { described_class.create(creation_params) }

    let(:creation_params) { {uuid: uuid, name: name} }
    let(:name) { "Scott" }
    let(:uuid) { SecureRandom.uuid }

    context "when no UUID is provided" do
      let(:user) { described_class.create(creation_params.except(:uuid)) }

      it "generates a UUID" do
        expect(user.uuid).to match(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-5][0-9a-f]{3}-[089ab][0-9a-f]{3}-[0-9a-f]{12}$/i)
      end
    end

    context "when the UUID is nil" do
      let(:uuid) { nil }

      it "will fail with an appropriate error message" do
        expect(user.errors.full_messages).to include("Uuid can't be blank")
      end
    end

    context "when the UUID is not unique" do
      let(:user) { described_class.create(creation_params) }

      before { described_class.create(creation_params) }

      it "will fail with an appropriate error message" do
        expect(user.errors.full_messages).to include("Uuid has already been taken")
      end
    end

    context "when the UUID is not formatted correctly" do
      let(:uuid) { "I'm a UUID" }

      it "will fail with an appropriate error message" do
        expect(user.errors.full_messages).to include("Uuid is invalid")
      end
    end

    context "when the name is nil" do
      let(:name) { nil }

      it "will fail with an appropriate error message" do
        expect(user.errors.full_messages).to include("Name can't be blank")
      end
    end

    context "with valid parameters" do
      it "creates a new record", aggregate: true do
        expect(user).to be_valid
      end
    end
  end
end
