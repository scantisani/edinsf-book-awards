class Election
  def initialize(ballots:, ranker: Ranker::Schulze.new(ballots: ballots))
    @ballots = ballots
    @ranker = ranker
  end

  delegate :winners, :ranking, to: :ranker

  def elect
    ranker.rank
  end

  private

  attr_reader :ranker
end
