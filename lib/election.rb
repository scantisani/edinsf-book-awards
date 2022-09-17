class Election
  def initialize(candidates, ballots)
    @candidates = candidates
    @ballots = ballots

    @preference_graph = PreferenceGraph.empty
  end

  attr_reader :preference_graph

  def elect
    set_initial_paths
    calculate_strongest_paths
    calculate_winners
    # calculate single winner
    # calculate ranking
  end

  def set_initial_paths
    candidates.each do |candidate_one|
      candidates.each do |candidate_two|
        next if candidate_one == candidate_two

        preference_graph.set_path(candidate_one, candidate_two, strength: num_ballots_preferring(candidate_one, candidate_two))
      end
    end
  end

  def calculate_strongest_paths
    candidates.each do |middle|
      candidates.each do |start|
        next if middle == start

        candidates.each do |finish|
          next if middle == finish || start == finish

          strongest_alternative = [preference_graph.path(start, middle), preference_graph.path(middle, finish)].min

          if preference_graph.path(start, finish) < strongest_alternative
            preference_graph.set_path(start, finish, strength: strongest_alternative)
          end
        end
      end
    end
  end

  def calculate_winners
    winners = []
    o_pairs = []

    candidates.each do |candidate_one|
      winners << candidate_one

      candidates.each do |candidate_two|
        next if candidate_one == candidate_two

        if preference_graph.path(candidate_two, candidate_one) > preference_graph.path(candidate_one, candidate_two)
          o_pairs << [candidate_two, candidate_one]
          winners.delete(candidate_one)
        end
      end
    end

    winners
  end

  private

  attr_writer :preference_graph
  attr_accessor :candidates, :ballots

  def num_candidates
    candidates.count
  end

  # @return [Integer] the number of ballots that rank +preferred_candidate+ higher than +compared_candidate+
  def num_ballots_preferring(preferred_candidate, compared_candidate)
    ballots.count { |ballot| ballot.index(preferred_candidate) < ballot.index(compared_candidate) }
  end
end
