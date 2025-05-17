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
    return 0 if string.empty?

    negative_numbers, delimiters_in_brackets = extract_delimiter_and_negatives(string)
    raise "negative numbers not allowed #{negative_numbers.join(', ')}" if negative_numbers.any?

    string = replace_delimiters(string, delimiters_in_brackets)

    # Extract all numbers from the string (ignoring newlines and spaces) and calculate their sum.
    # Numbers greater than MAX_VALUE are ignored in the sum.
    string.scan(/\d+/).sum { |n| (number = n.to_i) <= MAX_VALUE ? number : 0 }
  end

  private

  # Extracts all negative numbers and custom delimiters from the input string.
  # Returns an array of negative numbers (as strings) and an array of delimiters (as strings).
  # - Negative numbers are detected anywhere in the string (e.g., "-1").
  # - Custom delimiters are detected in the format //[<delimiter1>][<delimiter2>]...\n.
  # Example:
  #   extract_delimiter_and_negatives("//[***][%]\n1***-2%3")
  #   => [["-2"], ["***", "%"]]
  def extract_delimiter_and_negatives(string)
    negative_numbers = []
    delimiters_in_brackets = []
    string.scan(/(-\d+)|\[(.*?)\]/) do |negative, delimiter|
      negative_numbers << negative if negative
      delimiters_in_brackets << delimiter if delimiter
    end
    [negative_numbers, delimiters_in_brackets]
  end

  # Replaces all custom delimiters in the input string with commas to standardize separation.
  # Handles single/multiple delimiters, including those of any length specified in brackets (e.g., //[***][%]\n).
  # Also handle single-character delimiter if provided (e.g., //;\n1;2), it is also replaced.
  # Returns the substring after the first newline character, which contains the actual numbers to process.
  def replace_delimiters(string, delimiters)
    single_char_delimiter = delimiters.empty? && string.start_with?('//')
    single_char_delimiter && delimiters = [string[2]]
    return string if delimiters.empty?

    # use escape character `\\` to support delimiters like ^ in `#tr`
    string = string.tr("\\#{delimiters.join('\\')}", ',')

    # Extract the string after the first newline character
    first_newline_pos = string.index("\n")
    first_newline_pos ? string[(first_newline_pos + 1)..] : string
  end
end
