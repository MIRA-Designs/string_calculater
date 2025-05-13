# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'string_calculator'

##################################################################################
# TestStringCalculator class tests the StringCalculator class
#   The test cases are written using Minitest framework
#   The test cases are written in a way that they can be run using `ruby test_string_calculator.rb`
##################################################################################
class TestStringCalculator < Minitest::Test
  def test_empty_string
    str_cal = StringCalculator.new
    assert_equal 0, str_cal.add('')
  end
end
