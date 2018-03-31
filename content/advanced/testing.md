# Testing Ruby Code

Recent Ruby versions come with _bundled gem_ for testing, named [minitest](https://github.com/seattlerb/minitest). It provides a complete suite of testing facilities supporting TDD, BDD, mocking, and benchmarking.

Example of unit test with minitest, taken from its README:

    require "minitest/autorun"

    class TestMeme < Minitest::Test
      def setup
        @meme = Meme.new
      end

      def test_that_kitty_can_eat
        assert_equal "OHAI!", @meme.i_can_has_cheezburger?
      end

      def test_that_it_will_not_blend
        refute_match /^no/i, @meme.will_it_blend?
      end

      def test_that_will_be_skipped
        skip "test this later"
      end
    end

Another widely popular library for testing is [RSpec](http://rspec.info/). Here is example of its syntax, take from the README:

    RSpec.describe Bowling, "#score" do
      context "with no strikes or spares" do
        it "sums the pin count for each pin" do
          bowling = Bowling.new
          20.times { bowling.hit(4) }
          expect(bowling.score).to eq 80
        end
      end
    end

> *Note*: Minitest also supports RSpec-like syntax via `minitest/spec`.