require "rails_helper"

RSpec.describe Ranker::Schulze do
  subject(:ranker) { described_class.new(ballots: ballots, preference_graph: PreferenceGraph.empty) }

  let(:ballots) {}

  describe "#rank" do
    before { ranker.rank }

    context "with no ballots" do
      let(:ballots) { [] }

      it "returns an empty ranking" do
        expect(ranker.ranking).to be_empty
      end

      it "returns no winners" do
        expect(ranker.winners).to be_empty
      end
    end

    context "with a single ballot for one item" do
      let(:ballots) { [%i[a]] }

      it "returns that item as the entire ranking" do
        expect(ranker.ranking).to eq(%i[a])
      end

      it "returns that item as the winner" do
        expect(ranker.winners).to eq(%i[a])
      end
    end

    context "with three ballots for two items" do
      let(:ballots) { [%i[a b], %i[a b], %i[b a]] }

      it "ranks the items according to the number of votes" do
        expect(ranker.ranking).to eq(%i[a b])
      end

      it "returns the item with the most votes as the winner" do
        expect(ranker.winners).to eq(%i[a])
      end
    end

    context "with the votes in Example 1 from the Schulze paper" do
      let(:ballots) do
        [%i[a c d b]] * 8 +
          [%i[b a d c]] * 2 +
          [%i[c d b a]] * 4 +
          [%i[d b a c]] * 4 +
          [%i[d c b a]] * 3
      end

      it "returns the ranking for Example 1" do
        expect(ranker.ranking).to eq([:d, :a, :c, :b])
      end

      it "returns the winners for Example 1" do
        expect(ranker.winners).to eq([:d])
      end
    end

    context "with the votes in Example 7 from the Schulze paper" do
      let(:ballots) do
        [%i[a d e b c f]] * 3 +
          [%i[b f e c d a]] * 3 +
          [%i[c a b f d e]] * 4 +
          [%i[d b c e f a]] * 1 +
          [%i[d e f a b c]] * 4 +
          [%i[e c b d f a]] * 2 +
          [%i[f a c d b e]] * 2
      end

      it "returns the ranking for Example 7" do
        expect(ranker.ranking).to eq(%i[a b f d e c])
      end

      it "returns the winners for Example 7" do
        expect(ranker.winners).to eq([:a])
      end
    end

    context "with the votes in Example 13 from the Schulze paper" do
      let(:ballots) do
        [%i[a b c]] * 2 +
          [%i[b c a]] * 2 +
          [%i[c a b]]
      end

      it "returns the ranking for Example 13" do
        expect(ranker.ranking).to eq([:a, :b, :c])
      end

      it "returns the winners for Example 13" do
        expect(ranker.winners).to eq([:a, :b])
      end
    end
  end

  describe "#winners" do
    context "when #rank has not been called yet" do
      it "returns an empty array" do
        expect(ranker.winners).to be_empty
      end
    end
  end

  describe "#ranking" do
    context "when #rank has not been called yet" do
      it "returns an empty array" do
        expect(ranker.ranking).to be_empty
      end
    end
  end
end
