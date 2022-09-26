require "rails_helper"

RSpec.describe Election do
  let(:election) { described_class.new(ballots: ballots) }
  let(:ballots) {}

  describe "#elect" do
    before { election.elect }

    context "with the votes in Example 1 from the Schulze paper" do
      let(:ballots) do
        [%i[a c d b]] * 8 +
          [%i[b a d c]] * 2 +
          [%i[c d b a]] * 4 +
          [%i[d b a c]] * 4 +
          [%i[d c b a]] * 3
      end

      it "returns the correct winners for Example 1" do
        expect(election.winners).to eq([:d])
      end

      it "returns the correct ranking for Example 1" do
        expect(election.ranking).to eq([:d, :a, :c, :b])
      end
    end
  end
end
