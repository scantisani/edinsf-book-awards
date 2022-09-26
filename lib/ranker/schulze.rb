module Ranker
  class Schulze
    def initialize(ballots:, preference_graph: PreferenceGraph.empty)
      @ballots = ballots
      @graph = preference_graph

      @winners = []
      @o_pairs = []
      @ranking = []
    end

    attr_reader :winners, :ranking

    def rank
      set_initial_paths
      calculate_strongest_paths
      calculate_winners
      determine_ranking
    end

    private

    attr_reader :ballots
    attr_writer :winners, :ranking
    attr_accessor :o_pairs, :graph

    def set_initial_paths
      candidates.each do |candidate_one|
        candidates.each do |candidate_two|
          next if candidate_one == candidate_two

          graph.set_path(candidate_one, candidate_two, strength: num_ballots_preferring(candidate_one, candidate_two))
        end
      end
    end

    def calculate_strongest_paths
      candidates.each do |middle|
        candidates.each do |start|
          next if middle == start

          candidates.each do |finish|
            next if middle == finish || start == finish

            strongest_alternative = [graph.path(start, middle), graph.path(middle, finish)].min

            if graph.path(start, finish) < strongest_alternative
              graph.set_path(start, finish, strength: strongest_alternative)
            end
          end
        end
      end
    end

    def calculate_winners
      candidates.each do |candidate_one|
        winners << candidate_one

        candidates.each do |candidate_two|
          next if candidate_one == candidate_two

          if graph.path(candidate_two, candidate_one) > graph.path(candidate_one, candidate_two)
            o_pairs << [candidate_two, candidate_one]
            winners.delete(candidate_one)
          end
        end
      end
    end

    def determine_ranking
      self.ranking = candidates.sort do |a, b|
        pair = o_pairs.find { |pair| pair == [a, b] || pair == [b, a] }

        pair.index(a) <=> pair.index(b)
      end
    end

    def candidates
      @candidates ||= ballots.empty? ? [] : ballots.reduce(&:union)
    end

    # @return [Integer] the number of ballots that rank +preferred_candidate+ higher than +compared_candidate+
    def num_ballots_preferring(preferred_candidate, compared_candidate)
      ballots.count { |ballot| ballot.index(preferred_candidate) < ballot.index(compared_candidate) }
    end
  end
end
