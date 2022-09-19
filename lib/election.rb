class Election
  def initialize(ballots:, ranker: Ranker::Schulze.new(ballots: ballots))
    @ballots = ballots
    @ranker = ranker
  end

  def elect
    ranker.tap(&:set_initial_paths)
          .tap(&:calculate_strongest_paths)
          .tap(&:calculate_winners)
          .then(&:determine_ranking)
  end

  private

  attr_reader :ranker
end
