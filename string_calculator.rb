# frozen_string_literal: true

##################################################################################
# The method `add` in the StringCalculator class takes a string that contains numbers
#   separated by commas, delimiters, or newlines and returns the sum of numbers
#   by ommitting the delimiters, commas, and newlines.
#   The `add` method should handle the following cases:
#     1. The `add` method should return 0 for an empty string
#        The `add` method should return the number itself for a single number
#        The `add` method should return the sum of numbers for a string with multiple numbers
#     2. The `add` method should handle unknown amount of numbers
#     3. The `add` method should handle newlines between numbers
#     4. The `add` method should also handle custom delimiters by allowing the user to specify a delimiter
#        at the beginning of the string after the `//` prefix
#     5. The `add` method raising an exception if negative numbers present in the string
#     6. The `add` method should also handle multiple negative numbers showing all negative numbers in exception message
#     7. The `add` method should ignore numbers greater than 1000
#     8. Delimiters can be of any length with the format: "//[delimiter delimiter ..]\n..."
#     9. Allow multiple delimiters with the format: "//[delimiter1][delimiter2]\n.."
#     10. The `add` method should also handle multiple delimiters with length longer than one character
#        with format: "//[delimiter1delimiter1][delimiter2delimiter2]\n1delimiter1delimiter12delimiter2delimiter23"
##################################################################################
class StringCalculator
  MAX_VALUE = 1000
  def add(string)
    # If the string is empty, return 0
    return 0 if string.empty?

    negative_numbers, delimiters_in_brackets = extract_delimiter_and_negatives(string)
    # If the string contains negative numbers, raise an exception
    raise "negative numbers not allowed #{negative_numbers.join(', ')}" if negative_numbers.any?

    string = replace_delimiters(string, delimiters_in_brackets)
    # get only numbers, ignoring numbers > MAX_VALUE and sum them
    string.scan(/\d+/).sum { |n| (number = n.to_i) <= MAX_VALUE ? number : 0 }
  end

  private

  # if the string contains a custom delimiter, negative numbers then extract it
  def extract_delimiter_and_negatives(string)
    negative_numbers = []
    delimiters_in_brackets = []
    string.scan(/(-\d+)|\[(.*?)\]/) do |negative, delimiter|
      negative_numbers << negative if negative
      delimiters_in_brackets << delimiter if delimiter
    end
    [negative_numbers, delimiters_in_brackets]
  end

  # 1. Replace the delimiters in the string that contain in brackets (eg: [<delimiter>][<delimiter>])
  # and the only delimiter (eg: //<delimiter>\n) after the `//` prefix with comma
  # 2. Return the string after the first newline character.
  def replace_delimiters(string, delimiters)
    delimiters.empty? && string.start_with?('//') && delimiters = [string[2]]
    return string if delimiters.empty?

    string = string.tr("\\#{delimiters.join('\\')}", ',')
    # Extract the string after the first newline character
    first_newline_pos = string.index("\n") + 1
    string[first_newline_pos..]
  end
end
