class PreferenceGraph
  def self.empty
    new
  end

  def self.with_paths(paths)
    raise ArgumentError, "The 'paths' parameter may not be nil" if paths.nil?

    new(paths)
  end

  def path(from, to)
    raise ArgumentError, "Neither 'from' nor 'to' may be blank" if from.blank? || to.blank?

    paths.dig(from, to)
  end

  def set_path(from, to, strength:)
    raise ArgumentError, "None of 'from', 'to', or 'strength' may be blank" if from.blank? || to.blank? || strength.blank?

    paths[from] = {} unless paths.key?(from)
    paths[from].merge!(to => strength)
  end

  def ==(other)
    return false unless other.respond_to?(:paths, true)

    @paths == other.send(:paths)
  end
  alias_method :eql?, :==

  def hash
    arbitrary_integer = 45
    [arbitrary_integer, @paths].hash
  end

  def to_s
    @paths.to_s
  end

  private

  def initialize(paths = {})
    @paths = paths
  end

  attr_accessor :paths
end
