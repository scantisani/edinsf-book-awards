require "rails_helper"

RSpec.describe PreferenceGraph do
  subject(:graph) { described_class.empty }

  describe "#path" do
    describe "argument validation" do
      let(:expected_message) { "Neither 'from' nor 'to' may be blank" }

      context "when 'from' is nil or empty" do
        it "raises an ArgumentError", aggregate_failures: true do
          expect { graph.path(nil, "b") }.to raise_error ArgumentError, expected_message
          expect { graph.path("", "b") }.to raise_error ArgumentError, expected_message
        end
      end

      context "when 'to' is nil or empty" do
        it "raises an ArgumentError", aggregate_failures: true do
          expect { graph.path("a", nil) }.to raise_error ArgumentError, expected_message
          expect { graph.path("a", "") }.to raise_error ArgumentError, expected_message
        end
      end
    end

    context "when no path for the provided points exists" do
      it "returns nil" do
        expect(graph.path("a", "b")).to be_nil
      end
    end

    context "when the path exists" do
      before { graph.set_path("a", "b", strength: 1) }

      it "returns the path's strength value" do
        expect(graph.path("a", "b")).to eq(1)
      end
    end
  end

  describe "#set_path" do
    describe "argument validation" do
      let(:expected_message) { "None of 'from', 'to', or 'strength' may be blank" }

      context "when 'from' is nil or empty" do
        it "raises an ArgumentError", aggregate_failures: true do
          expect { graph.set_path(nil, "b", strength: 1) }.to raise_error ArgumentError, expected_message
          expect { graph.set_path("", "b", strength: 1) }.to raise_error ArgumentError, expected_message
        end
      end

      context "when 'to' is nil or empty" do
        it "raises an ArgumentError", aggregate_failures: true do
          expect { graph.set_path("a", nil, strength: 1) }.to raise_error ArgumentError, expected_message
          expect { graph.set_path("a", "", strength: 1) }.to raise_error ArgumentError, expected_message
        end
      end

      context "when 'strength' is nil" do
        it "raises an ArgumentError", aggregate_failures: true do
          expect { graph.set_path("a", "b", strength: nil) }.to raise_error ArgumentError, expected_message
        end
      end
    end

    context "when no path has been set yet" do
      it "sets a path's strength value" do
        graph.set_path("a", "b", strength: 1)

        expect(graph.path("a", "b")).to eq(1)
      end
    end

    context "when a path from that start point exists" do
      before do
        graph.set_path("a", "b", strength: 1)
        graph.set_path("a", "c", strength: 2)
      end

      it "sets the new path's strength value" do
        expect(graph.path("a", "c")).to eq(2)
      end

      it "does not overwrite the existing path" do
        expect(graph.path("a", "b")).to eq(1)
      end
    end

    context "when that path already exists" do
      before do
        graph.set_path("a", "b", strength: 1)
        graph.set_path("a", "b", strength: 2)
      end

      it "overwrites the path's strength value" do
        expect(graph.path("a", "b")).to eq(2)
      end
    end
  end

  describe "#strengthen!" do
    subject(:strong_graph) { initial_graph.strengthen! }

    let(:initial_graph) {}

    context "with an empty graph" do
      let(:initial_graph) { described_class.empty }

      it "changes nothing" do
        expect(strong_graph).to eq(initial_graph)
      end
    end

    context "with a graph that has nothing to strengthen" do
      let(:initial_graph) do
        described_class.with_paths(
          {
            a: {b: 2},
            b: {a: 1}
          }
        )
      end

      it "changes nothing" do
        expect(strong_graph).to eq(initial_graph)
      end
    end

    context "with the initial graph in Example 1 from the Schulze paper" do
      let(:initial_graph) do
        described_class.with_paths(
          {
            a: {b: 2, c: 14, d: 10},
            b: {a: 13, c: 6, d: 2},
            c: {a: 7, b: 15, d: 12},
            d: {a: 11, b: 19, c: 9}
          }
        )
      end

      let(:expected_graph) do
        described_class.with_paths(
          {
            a: {b: 14, c: 14, d: 12},
            b: {a: 13, c: 13, d: 12},
            c: {a: 13, b: 15, d: 12},
            d: {a: 13, b: 19, c: 13}
          }
        )
      end

      it "creates the final preference graph for Example 1" do
        expect(strong_graph).to eq(expected_graph)
      end
    end

    context "with initial graph in Example 7 from the Schulze paper" do
      let(:initial_graph) do
        described_class.with_paths(
          {
            a: {b: 13, c: 9, d: 9, e: 9, f: 13},
            b: {a: 6, c: 11, d: 9, e: 10, f: 13},
            c: {a: 10, b: 8, d: 11, e: 7, f: 10},
            d: {a: 10, b: 10, c: 8, e: 14, f: 10},
            e: {a: 10, b: 9, c: 12, d: 5, f: 10},
            f: {a: 12, b: 6, c: 9, d: 9, e: 9}
          }
        )
      end

      let(:expected_graph) do
        described_class.with_paths(
          {
            a: {b: 13, c: 11, d: 11, e: 11, f: 13},
            b: {a: 12, c: 11, d: 11, e: 11, f: 13},
            c: {a: 10, b: 10, d: 11, e: 11, f: 10},
            d: {a: 10, b: 10, c: 12, e: 14, f: 10},
            e: {a: 10, b: 10, c: 12, d: 11, f: 10},
            f: {a: 12, b: 12, c: 11, d: 11, e: 11}
          }
        )
      end

      it "creates the final preference graph for Example 7" do
        expect(strong_graph).to eq(expected_graph)
      end
    end

    context "with the initial graph in Example 13 from the Schulze paper" do
      let(:initial_graph) do
        described_class.with_paths(
          {
            a: {b: 3, c: 2},
            b: {a: 2, c: 4},
            c: {a: 3, b: 1}
          }
        )
      end

      let(:expected_graph) do
        described_class.with_paths(
          {
            a: {b: 3, c: 3},
            b: {a: 3, c: 4},
            c: {a: 3, b: 3}
          }
        )
      end

      it "creates the final preference graph for Example 13" do
        expect(strong_graph).to eq(expected_graph)
      end
    end
  end

  describe "#empty" do
    subject(:graph) { described_class.empty }

    it "initializes an empty graph" do
      expect(graph).to eq(described_class.with_paths({}))
    end
  end

  describe "#with_paths" do
    subject(:graph) { described_class.with_paths(paths) }

    context "when paths is an empty hash" do
      let(:paths) { {} }

      it "initializes a graph with empty paths" do
        expect(graph.path("a", "b")).to be_nil
      end
    end

    context "when paths is nil" do
      let(:paths) { nil }

      it "raises an ArgumentError" do
        expect { graph }.to raise_error ArgumentError, "The 'paths' parameter may not be nil"
      end
    end

    context "when paths is a hash of hashes" do
      let(:paths) do
        {
          "a" => {"b" => 1, "c" => 2},
          "b" => {"a" => 3, "c" => 4}
        }
      end

      it "initializes a graph with preset paths", aggregate_failures: true do
        expect(graph.path("a", "b")).to eq(1)
        expect(graph.path("a", "c")).to eq(2)
        expect(graph.path("b", "a")).to eq(3)
        expect(graph.path("b", "c")).to eq(4)
      end
    end
  end

  describe "equal?" do
    let(:graph) { described_class.with_paths(paths) }
    let(:paths) do
      {
        "a" => {"b" => 1, "c" => 2},
        "b" => {"a" => 3, "c" => 4}
      }
    end

    let(:other_graph) { described_class.with_paths(other_paths) }
    let(:other_paths) { {} }

    context "when the graphs have the same paths" do
      let(:other_paths) { paths }

      it "returns true" do
        expect(graph).to eq(other_graph)
      end
    end

    context "when the graphs do not have the same paths" do
      let(:other_paths) do
        {
          "a" => {"f" => 1, "g" => 2},
          "b" => {"h" => 3, "i" => 4}
        }
      end

      it "returns false" do
        expect(graph).not_to eq(other_graph)
      end
    end
  end

  describe "#hash" do
    let(:graph) { described_class.with_paths(paths) }
    let(:paths) do
      {
        "a" => {"b" => 1, "c" => 2},
        "b" => {"a" => 3, "c" => 4}
      }
    end

    it "is not simply equal to the hash for 'paths'" do
      expect(graph.hash).not_to eq(paths.hash)
    end

    context "when one graph is equal to another" do
      let(:other_graph) { described_class.with_paths(paths) }

      it "returns the same value for both graphs" do
        expect(graph.hash).to eq(other_graph.hash)
      end
    end
  end

  describe "#to_s" do
    let(:graph) { described_class.with_paths(paths) }
    let(:paths) do
      {
        "a" => {"b" => 1, "c" => 2},
        "b" => {"a" => 3, "c" => 4}
      }
    end

    let(:expected_output) do
      <<~OUTPUT.chomp
        {"a"=>{"b"=>1, "c"=>2}, "b"=>{"a"=>3, "c"=>4}}
      OUTPUT
    end

    it "returns the contents of 'paths'" do
      expect(graph.to_s).to eq(expected_output)
    end
  end
end
