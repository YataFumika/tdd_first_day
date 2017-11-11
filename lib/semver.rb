class Semver
  def initialize(major, minor, patch)
    argument_check(major)
    argument_check(minor)
    argument_check(patch)

    @major = major
    @minor = minor
    @patch = patch
  end
  def version
    "#{@major}.#{@minor}.#{@patch}"
  end

  def equal other
    version == other.version
  end

  private

  def argument_check(val)
    raise ArgumentError.new if val < 0
  end
end
