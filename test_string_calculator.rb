# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'string_calculator'

##################################################################################
# TestStringCalculator class tests the StringCalculator class
#   The test cases are written using Minitest framework
#   The test cases are written in a way that they can be run using `ruby test_string_calculator.rb`
##################################################################################
class TestStringCalculator < Minitest::Test
  def setup
    @calculator = StringCalculator.new
  end

  def test_empty_string
    assert_equal 0, @calculator.add('')
  end

  def test_single_number_string
    assert_equal 1, @calculator.add('1')
  end

  def test_two_numbers_comma_separated
    assert_equal 3, @calculator.add('1,2')
  end

  def test_unknown_amount_of_numbers
    assert_equal 335, @calculator.add('1,23,55,77,83,70,26')
  end
end
