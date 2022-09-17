class Election
  def initialize(candidates, ballots)
    @candidates = candidates
    @ballots = ballots

    @path_strengths = Array.new(num_candidates) { Array.new(num_candidates) }
  end

  attr_reader :path_strengths

  def elect
    initialize_matrices
    calculate_strongest_paths
    calculate_winners
    # calculate single winner
    # calculate ranking
  end

  def initialize_matrices
    candidates.each.with_index do |candidate_one, i|
      candidates.each.with_index do |candidate_two, j|
        next if i == j

        path_strengths[i][j] = num_ballots_preferring(candidate_one, candidate_two)
      end
    end
  end

  def calculate_strongest_paths
    num_candidates.times do |middle|
      num_candidates.times do |start|
        next if middle == start

        num_candidates.times do |finish|
          next if middle == finish || start == finish

          strongest_alternative = [path_strengths[start][middle], path_strengths[middle][finish]].min

          if path_strengths[start][finish] < strongest_alternative
            path_strengths[start][finish] = strongest_alternative
          end
        end
      end
    end
  end

  def calculate_winners
    winners = []
    o_pairs = []

    num_candidates.times do |i|
      winners << candidates[i]
      num_candidates.times do |j|
        next if i == j

        if path_strengths[j][i] > path_strengths[i][j]
          o_pairs << [j, i]
          winners.delete(candidates[i])
        end
      end
    end

    winners
  end

  private

  attr_writer :path_strengths
  attr_accessor :candidates, :ballots

  def num_candidates
    candidates.count
  end

  # @return [Integer] the number of ballots that rank +preferred_candidate+ higher than +compared_candidate+
  def num_ballots_preferring(preferred_candidate, compared_candidate)
    ballots.count { |ballot| ballot.index(preferred_candidate) < ballot.index(compared_candidate) }
  end
end
