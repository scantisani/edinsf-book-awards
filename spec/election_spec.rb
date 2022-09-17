require "rails_helper"

RSpec.describe Election do
  let(:election) { described_class.new(candidates, ballots) }
  let(:candidates) {}
  let(:ballots) {}

  let(:strength_matrix) {}

  describe "#initialize_matrices" do
    before { election.initialize_matrices }

    context "with no ballots" do
      let(:candidates) { [] }
      let(:ballots) { [] }

      let(:strength_matrix) { [] }

      it "creates an empty path strengths matrix" do
        expect(election.path_strengths).to eq(strength_matrix)
      end
    end

    context "with a single ballot for one item" do
      let(:candidates) { %i[a] }
      let(:ballots) { [%i[a]] }

      let(:strength_matrix) { [[nil]] }

      it "creates a path strength matrix with one nil cell" do
        expect(election.path_strengths).to eq(strength_matrix)
      end
    end

    context "with three ballots for two items" do
      let(:candidates) { %i[a b] }
      let(:ballots) { [%i[a b], %i[a b], %i[b a]] }

      let(:strength_matrix) do
        [
          [nil, 2],
          [1, nil]
        ]
      end

      it "returns a 2-dimensional path strength matrix with initial strengths" do
        expect(election.path_strengths).to eq(strength_matrix)
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

      let(:strength_matrix) do
        [
          [nil, 8, 14, 10],
          [13, nil, 6, 2],
          [7, 15, nil, 12],
          [11, 19, 9, nil]
        ]
      end

      it "returns the initial path strength matrix for Example 1" do
        expect(election.path_strengths).to eq(strength_matrix)
      end
    end
  end

  describe "#calculate_strongest_paths" do
    before do
      election.initialize_matrices
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

      let(:strength_matrix) do
        [
          [nil, 14, 14, 12],
          [13, nil, 13, 12],
          [13, 15, nil, 12],
          [13, 19, 13, nil]
        ]
      end

      it "returns the final strength matrix for Example 1" do
        expect(election.path_strengths).to eq(strength_matrix)
      end
    end
  end

  describe "#calculate_winners" do
    before do
      election.initialize_matrices
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
end
