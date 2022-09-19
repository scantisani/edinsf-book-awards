require "rails_helper"

RSpec.describe Election do
  let(:election) { described_class.new(ballots) }
  let(:candidates) {}
  let(:ballots) {}

  describe "#set_initial_paths" do
    before { election.set_initial_paths }

    context "with no ballots" do
      let(:candidates) { [] }
      let(:ballots) { [] }

      it "creates an empty preference graph" do
        expect(election.preference_graph).to eq(PreferenceGraph.empty)
      end
    end

    context "with a single ballot for one item" do
      let(:candidates) { %i[a] }
      let(:ballots) { [%i[a]] }

      it "creates an empty preference graph" do
        expect(election.preference_graph).to eq(PreferenceGraph.empty)
      end
    end

    context "with three ballots for two items" do
      let(:candidates) { %i[a b] }
      let(:ballots) { [%i[a b], %i[a b], %i[b a]] }

      let(:graph) do
        PreferenceGraph.with_paths(
          {
            a: {b: 2},
            b: {a: 1}
          }
        )
      end

      it "returns a 2-dimensional path strength matrix with initial strengths" do
        expect(election.preference_graph).to eq(graph)
      end
    end

    context "with the votes in Example 1 from the Schulze paper" do
      let(:candidates) { %i[a b c d] }
      let(:ballots) do
        [%i[a c d b]] * 8 +
          [%i[b a d c]] * 2 +
          [%i[c d b a]] * 4 +
          [%i[d b a c]] * 4 +
          [%i[d c b a]] * 3
      end

      let(:graph) do
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
        expect(election.preference_graph).to eq(graph)
      end
    end
  end

  describe "#calculate_strongest_paths" do
    before do
      election.set_initial_paths
      election.calculate_strongest_paths
    end

    context "with the votes in Example 1 from the Schulze paper" do
      let(:candidates) { %i[a b c d] }
      let(:ballots) do
        [%i[a c d b]] * 8 +
          [%i[b a d c]] * 2 +
          [%i[c d b a]] * 4 +
          [%i[d b a c]] * 4 +
          [%i[d c b a]] * 3
      end

      let(:graph) do
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
        expect(election.preference_graph).to eq(graph)
      end
    end
  end

  describe "#calculate_winners" do
    before do
      election.set_initial_paths
      election.calculate_strongest_paths
    end

    context "with the votes in Example 1 from the Schulze paper" do
      let(:candidates) { %i[a b c d] }
      let(:ballots) do
        [%i[a c d b]] * 8 +
          [%i[b a d c]] * 2 +
          [%i[c d b a]] * 4 +
          [%i[d b a c]] * 4 +
          [%i[d c b a]] * 3
      end

      it "returns the winner for Example 1" do
        expect(election.calculate_winners).to eq([:d])
      end
    end
  end

  describe "#elect" do
    context "with the votes in Example 1 from the Schulze paper" do
      let(:candidates) { %i[a b c d] }
      let(:ballots) do
        [%i[a c d b]] * 8 +
          [%i[b a d c]] * 2 +
          [%i[c d b a]] * 4 +
          [%i[d b a c]] * 4 +
          [%i[d c b a]] * 3
      end

      it "returns the ranking for Example 1" do
        expect(election.elect).to eq([:d, :a, :c, :b])
      end
    end
  end
end
