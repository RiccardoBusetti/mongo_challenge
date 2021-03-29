# frozen_string_literal: true

require_relative 'mongo_challenge'

module Testable
  module Assertions
    class AssertionFailed < StandardError; end

    def assert_strings_equal(received, expected)
      raise AssertionFailed, "Expected #{expected} but got #{received}." unless received.eql?(expected)
    end

    def assert_strings_not_equal(received, expected)
      raise AssertionFailed, "Not expecting #{expected} but got #{received}." if received.eql?(expected)
    end
  end

  module Engine
    class TestRunner
      def initialize(clazz)
        @clazz = clazz.new
      end

      def test_all
        successful_tests = 0
        time_elapsed = profile do
          successful_tests = clazz_test_methods
                             .map { |method_name| test_method(method_name) }
                             .compact
                             .length
        end

        show_tests_results(
          successful_tests,
          clazz_test_methods.length,
          time_elapsed
        )
      end

      private

      def clazz_test_methods
        @clazz.methods
              .grep(/test.+/)
      end

      def test_method(method_name)
        @clazz.send(method_name)
        true
      rescue Assertions::AssertionFailed => e
        puts e
        nil
      end

      def show_tests_results(successful_tests, all_tests, time_elapsed)
        puts "#{successful_tests}/#{all_tests} tests executed successfully in #{time_elapsed}ms."
      end

      def profile
        start = Time.now
        yield
        finish = Time.now

        ((finish.to_f - start.to_f) * 1000).round(2)
      end
    end
  end
end

class FlattenTest
  include Testable::Assertions

  def test_flatten_if_input_is_empty
    input = ''
    expected_output = ''

    output = flatten_string(input)
    assert_strings_equal(output, expected_output)
  end

  def test_flatten_if_input_is_empty_object
    input = '{}'
    expected_output = '{}'

    output = flatten_string(input)
    assert_strings_equal(output, expected_output)
  end

  def test_flatten_if_input_has_one_level
    input = '{"a":1,"b":"hello"}'
    expected_output = '{"a":1,"b":"hello"}'

    output = flatten_string(input)
    assert_strings_equal(output, expected_output)
  end

  def test_flatten_if_input_has_multiple_levels
    input = '{"a":1,"b":"hello","c":{"d":"world"}}'
    expected_output = '{"a":1,"b":"hello","c.d":"world"}'

    output = flatten_string(input)
    assert_strings_equal(output, expected_output)
  end
end

Testable::Engine::TestRunner
  .new(FlattenTest)
  .test_all
