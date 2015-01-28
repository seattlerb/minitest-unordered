require "minitest/unit"
require "minitest/spec"

module MiniTest::Unit::Unordered
  VERSION = "1.0.1"

  ##
  # Fails unless +a+ contains the same contents as +b+, regardless
  # of order.
  #
  #    assert_equal_unordered %w[a a b c], %w[a b c a] # pass
  #
  # NOTE: This uses Hash#== to determine collection equivalence, as
  # such, do not expect it to behave the same as +assert_equal+.
  #
  #    assert_equal [1], [1.0]                         # pass
  #    assert_equal({ 1 => true }, { 1.0 => true })    # fail
  #    assert_equal_unordered [1], [1.0]               # fail

  def assert_equal_unordered a, b, msg = nil
    msg = message(msg) {
      "Expected #{mu_pp a} to be equivalent to #{mu_pp b}"
    }

    assert_kind_of Enumerable, a
    assert_kind_of Enumerable, b

    c = Hash.new { |h,k| h[k] = 0 }; a.each do |e| c[e] += 1 end
    d = Hash.new { |h,k| h[k] = 0 }; b.each do |e| d[e] += 1 end

    assert c == d, msg
  end
end

class MiniTest::Unit::TestCase
  include MiniTest::Unit::Unordered
end

module MiniTest::Spec::Unordered
  ##
  # See MiniTest::Assertions#assert_equal_unordered
  #
  #    collection.must_equal_unordered other
  #
  # :method: must_equal_unordered

  infect_an_assertion :assert_equal_unordered, :must_equal_unordered, :reverse
end

class Object # :nodoc:
  include MiniTest::Spec::Unordered
end
