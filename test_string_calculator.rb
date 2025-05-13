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

  def test_newline_between_numbers
    assert_equal 6, @calculator.add("1\n2,3")
  end

  def test_multiple_newlines_between_numbers
    assert_equal 10, @calculator.add("1\n2\n3,4\n\n \n \n")
  end

  # format: //[delimiter]\n[numbers]
  def test_custom_single_char_delimiter
    assert_equal 3, @calculator.add("//;\n1;2")
  end

  # format: //[delimiter]\n[numbers][delimiter][numbers][delimiter][numbers][delimiter]
  def test_custom_multi_char_delimiter
    assert_equal 11, @calculator.add("//;\n2,3\n\n \n \n 4; 2;")
  end

  def test_negative_number_raise_exception
    error = assert_raises(Exception) { @calculator.add('-1,2') }
    assert_match(/negative numbers not allowed -1/, error.message)
  end

  def test_multiple_negative_numbers
    error = assert_raises(Exception) { @calculator.add("//;\n2,-3\n\n \n -8\n 4; -2;") }
    assert_match(/negative numbers not allowed -3, -8, -2/, error.message)
  end

  def test_ignore_numbers_greater_than_thousand
    assert_equal 2, @calculator.add('1001,2')
    assert_equal 1006, @calculator.add("//)\n1\n2,3\n)\n1000)")
    assert_equal 8, @calculator.add("4\n\n3\n1001,\n1002,\n\n1003,\n1")
  end

  # format: "//[delimiter]\n"
  def test_multi_char_delimiter
    assert_equal 6, @calculator.add("//[***]\n1***2***3")
    assert_equal 6, @calculator.add("//[**]\n1**2\n*3*****")
  end

  # format: "//[delimiter1][delimiter2]\n"
  def test_multiple_delimiters
    assert_equal 6, @calculator.add("//[*][%]\n1*2%3")
    assert_equal 12, @calculator.add("//[^][#]\n1#2^3#6^#^#^")
  end
end
