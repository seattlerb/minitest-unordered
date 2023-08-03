require "minitest/autorun"
require "minitest/unordered"

class TestMinitestUnordered < Minitest::Test
  def setup
    super

    Minitest::Test.reset

    @tc = Minitest::Test.new 'fake tc'
    @assertion_count = 1
  end

  def teardown
    assert_equal @assertion_count, @tc.assertions
  end

  def test_assert_equal_unordered_when_comparable_elements
    @assertion_count += 2

    @tc.assert_equal_unordered [1, 2, 3], [2, 3, 1]
  end

  def test_assert_equal_unordered_when_not_comparable_elements
    @assertion_count += 2

    @tc.assert_equal_unordered [true, false, true], [true, true, false]
  end

  def test_assert_equal_unordered_when_enumerable_actual
    @assertion_count += 2

    es = Class.new do
      include Enumerable

      def initialize
        @elems = [true, false, true]
      end

      def each
        @elems.each { |e| yield e }
      end
    end.new

    @tc.assert_equal_unordered es, [true, true, false]
  end

  def test_assert_equal_unordered_triggered_more
    @assertion_count += 3

    e = @tc.assert_raises Minitest::Assertion do
      @tc.assert_equal_unordered [true, true], [true]
    end

    expected = "Expected [true, true] to be equivalent to [true]."
    assert_equal expected, e.message
  end

  def test_assert_equal_unordered_triggered_less
    @assertion_count += 3

    e = @tc.assert_raises Minitest::Assertion do
      @tc.assert_equal_unordered [true], [true, true]
    end

    expected = "Expected [true] to be equivalent to [true, true]."
    assert_equal expected, e.message
  end

  def test_assert_equal_unordered_triggered_different
    @assertion_count += 3

    e = @tc.assert_raises Minitest::Assertion do
      @tc.assert_equal_unordered [true, false, true], [false, false, true]
    end

    expected =
      "Expected [true, false, true] to be equivalent to [false, false, true]."
    assert_equal expected, e.message
  end
end

describe Minitest::Spec::Unordered do
  it "needs to be sensible about must_equal_unordered order" do
    _(_([1, 2, 3]).must_equal_unordered([1, 2, 3])).must_equal true

    e = assert_raises Minitest::Assertion do
      _([1, 2]).must_equal_unordered [1, 2, 3]
    end

    assert_equal "Expected [1, 2] to be equivalent to [1, 2, 3].", e.message

    e = assert_raises Minitest::Assertion do
      _([1, 2]).must_equal_unordered [1, 2, 3], "msg"
    end

    exp = "msg.\nExpected [1, 2] to be equivalent to [1, 2, 3]."
    assert_equal exp, e.message

    _(self.assertions).must_equal 14
  end
end
