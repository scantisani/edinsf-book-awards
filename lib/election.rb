class Election
  def initialize(ballots:, ranker: Ranker::Schulze.new(ballots: ballots))
    @ballots = ballots
    @ranker = ranker
  end

  def elect
    ranker.rank
  end

  private

  attr_reader :ranker
end
