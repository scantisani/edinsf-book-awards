require "rails_helper"

RSpec.describe Ranker::Schulze do
  subject(:ranker) { described_class.new(ballots: ballots, preference_graph: graph) }

  let(:graph) { PreferenceGraph.empty }
  let(:ballots) {}

  describe "#rank" do
    before { ranker.rank }

    context "with no ballots" do
      let(:ballots) { [] }

      it "creates an empty preference graph" do
        expect(graph).to eq(PreferenceGraph.empty)
      end

      it "returns an empty ranking" do
        expect(ranker.ranking).to be_empty
      end

      it "returns no winners" do
        expect(ranker.winners).to be_empty
      end
    end

    context "with a single ballot for one item" do
      let(:ballots) { [%i[a]] }

      it "creates an empty preference graph" do
        expect(graph).to eq(PreferenceGraph.empty)
      end

      it "returns that item as the entire ranking" do
        expect(ranker.ranking).to eq(%i[a])
      end

      it "returns that item as the winner" do
        expect(ranker.winners).to eq(%i[a])
      end
    end

    context "with three ballots for two items" do
      let(:ballots) { [%i[a b], %i[a b], %i[b a]] }

      let(:expected_graph) do
        PreferenceGraph.with_paths(
          {
            a: {b: 2},
            b: {a: 1}
          }
        )
      end

      it "creates a preference graph with two nodes" do
        expect(graph).to eq(expected_graph)
      end

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

      let(:expected_graph) do
        PreferenceGraph.with_paths(
          {
            a: {b: 14, c: 14, d: 12},
            b: {a: 13, c: 13, d: 12},
            c: {a: 13, b: 15, d: 12},
            d: {a: 13, b: 19, c: 13}
          }
        )
      end

      it "creates the final preference graph for Example 1" do
        expect(graph).to eq(expected_graph)
      end

      it "returns the ranking for Example 1" do
        expect(ranker.ranking).to eq([:d, :a, :c, :b])
      end

      it "returns the winners for Example 1" do
        expect(ranker.winners).to eq([:d])
      end
    end

    context "with the votes in Example 13 from the Schulze paper" do
      let(:ballots) do
        [%i[a b c]] * 2 +
          [%i[b c a]] * 2 +
          [%i[c a b]]
      end

      let(:expected_graph) do
        PreferenceGraph.with_paths(
          {
            a: {b: 3, c: 3},
            b: {a: 3, c: 4},
            c: {a: 3, b: 3}
          }
        )
      end

      it "creates the final preference graph for Example 13" do
        expect(graph).to eq(expected_graph)
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
