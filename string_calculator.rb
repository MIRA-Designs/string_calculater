# frozen_string_literal: true

##################################################################################
# StringCalculator class that has only one method `add`
#   The `add` method takes a string that contains numbers separated by commas, delimiters, or newlines
#   and returns the sum of numbers by ommitting the delimiters, commas, and newlines
#   1. The `add` method should return 0 for an empty string
#      The `add` method should return the number itself for a single number
#      The `add` method should return the sum of numbers for a string with multiple numbers
#   2. The `add` method should handle unknown amount of numbers
#   3. The `add` method should handle newlines between numbers
#   4. The `add` method should also handle custom delimiters by allowing the user to specify a delimiter
#        at the beginning of the string after the `//` prefix
#   5. The `add` method raising an exception if negative numbers present in the string
#   6. The `add` method should also handle multiple negative numbers showing all negative numbers in exception message
#   7. The `add` method should ignore numbers greater than 1000
#   8. Delimiters can be of any length with the format: "//[delimiter delimiter ..]\n..."
#   9. Allow multiple delimiters with the format: "//[delimiter1][delimiter2]\n.."
#   10. The `add` method should also handle multiple delimiters with length longer than one character
#       with format: "//[delimiter1delimiter1][delimiter2delimiter2]\n1delimiter1delimiter12delimiter2delimiter23"
##################################################################################
class StringCalculator
  MAX_VALUE = 1000
  def add(string)
    # If the string is empty, return 0
    return 0 if string.empty?

    raise_if_negatives!(string)
    string = extract_custom_delimiters(string)

    numbers = numbers_array(string)
    # sum in one pass, ignoring values > MAX_VALUE
    numbers.sum { |n| n <= MAX_VALUE ? n : 0 }
  end

  private

  # If the string contains negative numbers, raise an exception
  def raise_if_negatives!(string)
    negative_numbers = string.scan(/-\d+/)
    raise "negative numbers not allowed #{negative_numbers.join(', ')}" if negative_numbers.any?
  end

  # if the string contains a custom delimiter, extract it
  def extract_custom_delimiters(string)
    # if string format: //[delimiter delimiter ..]\n... or //[delimiter1][delimiter2]\n...
    multi_delimiters = string.scan(/\[(.*?)\]/).flatten
    if multi_delimiters.any?
      multi_delimiters.each { |delimiter| string = replace_delimiter_by_comma(string, delimiter) }
      string_after_newline(string)
    # if string format: //delimiter\n...
    elsif string.start_with?('//')
      string = replace_delimiter_by_comma(string, string[2])
      string_after_newline(string)
    else
      string
    end
  end

  # Replace new lines with commas and split by comma
  def numbers_array(string)
    comma_separated = string.tr("\n", ',').split(',')
    comma_separated.map(&:to_i)
  end

  # Extract the string after the first newline character
  def string_after_newline(string)
    first_newline_pos = string.index("\n") + 1
    string[first_newline_pos..]
  end

  def replace_delimiter_by_comma(string, delimiter)
    string.tr(delimiter, ',')
  end
end
