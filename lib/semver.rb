class Semver
  def initialize(major, minor, patch)
    validate major, minor, patch

    @major = major
    @minor = minor
    @patch = patch
  end

  def to_s
    "#{@major}.#{@minor}.#{@patch}"
  end

  def == other
    to_s == other.to_s
  end

  def update_patch
    self.class.new @major, @minor, @patch+1
  end

  def update_minor
    self.class.new @major, @minor+1, 0
  end

  def update_major
    self.class.new @major+1, 0, 0
  end

  private

  def validate major, minor, patch
    argument_check(major)
    argument_check(minor)
    argument_check(patch)
  end

  def argument_check(val)
    raise ArgumentError.new if val < 0
    raise ArgumentError.new unless val.instance_of? Integer
  end
end
