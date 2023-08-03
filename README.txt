= minitest-unordered

home :: https://github.com/seattlerb/minitest-unordered
rdoc :: http://docs.seattlerb.org/minitest-unordered

== DESCRIPTION:

Adds a new assertion to minitest for checking the contents of a collection,
ignoring element order.

== FEATURES/PROBLEMS:

* The actual and expected collections must be Enumerable.
* Uses Hash#== for determining collection equivalence; as such, element
  equality does not behave the same as with +assert_equal+.

== SYNOPSIS:

  assert_equal_unordered %w[a a b c], %w[a b c a] # pass
  assert_equal_unordered %w[a b b c], %w[a a b c] # fail

  [1, 2, 3].must_equal_unordered [3, 1, 2] # pass
  [1, 2, 3].must_equal_unordered [1, 2, 2] # fail

=== EXAMPLE:

  require "minitest/autorun"
  require "minitest/unordered"

  class ExampleTest < Minitest::Test
    EXPECTED_DEPS = [
      ["hoe",  "~> 2.13.1"],
      ["rdoc", "= 3.9"],
      ["rdoc", "= 3.8"],
      ["hoe",  "~> 2.13.3"],
      ["hoe",  "~> 2.13.2"],
      ["hoe",  "~> 2.13.0"],
      ["rdoc", "= 3.12"]
    ]

    def setup
      @actual_deps = [
        ["rdoc", "= 3.9"],
        ["hoe",  "~> 2.13.2"],
        ["hoe",  "~> 2.13.3"],
        ["rdoc", "= 3.8"],
        ["hoe",  "~> 2.13.1"],
        ["hoe",  "~> 2.13.0"],
        ["rdoc", "= 3.12"]
      ]
    end

    def test_expected_deps
      assert_equal_unordered @actual_deps, EXPECTED_DEPS
    end
  end

== REQUIREMENTS:

* minitest

== INSTALL:

* sudo gem install minitest-unordered

== LICENSE:

(The MIT License)

Copyright (c) Ryan Davis, seattle.rb

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
