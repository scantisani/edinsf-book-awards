require "rails_helper"

RSpec.describe Ranker::Schulze do
  subject(:ranker) { described_class.new(ballots: ballots, preference_graph: graph) }

  let(:graph) { PreferenceGraph.empty }
  let(:ballots) {}

  shared_context "with ballots from Example 1" do
    let(:ballots) do
      [%i[a c d b]] * 8 +
        [%i[b a d c]] * 2 +
        [%i[c d b a]] * 4 +
        [%i[d b a c]] * 4 +
        [%i[d c b a]] * 3
    end
  end

  describe "#set_initial_paths" do
    before { ranker.set_initial_paths }

    context "with no ballots" do
      let(:ballots) { [] }

      it "creates an empty preference graph" do
        expect(graph).to eq(PreferenceGraph.empty)
      end
    end

    context "with a single ballot for one item" do
      let(:ballots) { [%i[a]] }

      it "creates an empty preference graph" do
        expect(graph).to eq(PreferenceGraph.empty)
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

      it "returns a 2-dimensional path strength matrix with initial strengths" do
        expect(graph).to eq(expected_graph)
      end
    end

    context "with the votes in Example 1 from the Schulze paper" do
      include_context "with ballots from Example 1"

      let(:expected_graph) do
        PreferenceGraph.with_paths(
          {
            a: {b: 8, c: 14, d: 10},
            b: {a: 13, c: 6, d: 2},
            c: {a: 7, b: 15, d: 12},
            d: {a: 11, b: 19, c: 9}
          }
        )
      end

      it "returns the initial path strength matrix for Example 1" do
        expect(graph).to eq(expected_graph)
      end
    end
  end

  describe "#calculate_strongest_paths" do
    before do
      ranker.set_initial_paths
      ranker.calculate_strongest_paths
    end

    context "with the votes in Example 1 from the Schulze paper" do
      include_context "with ballots from Example 1"

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

      it "returns the final preference graph for Example 1" do
        expect(graph).to eq(expected_graph)
      end
    end
  end

  describe "#calculate_winners" do
    before do
      ranker.set_initial_paths
      ranker.calculate_strongest_paths
    end

    context "with the votes in Example 1 from the Schulze paper" do
      include_context "with ballots from Example 1"

      it "returns the winner for Example 1" do
        expect(ranker.calculate_winners).to eq([:d])
      end
    end
  end

  describe "#determine_ranking" do
    before do
      ranker.set_initial_paths
      ranker.calculate_strongest_paths
      ranker.calculate_winners
    end

    context "with the votes in Example 1 from the Schulze paper" do
      include_context "with ballots from Example 1"

      it "returns the ranking for Example 1" do
        expect(ranker.determine_ranking).to eq([:d, :a, :c, :b])
      end
    end
  end

  describe "#rank" do
    context "with the votes in Example 1 from the Schulze paper" do
      include_context "with ballots from Example 1"

      it "returns the ranking for Example 1" do
        expect(ranker.rank).to eq([:d, :a, :c, :b])
      end
    end
  end
end
