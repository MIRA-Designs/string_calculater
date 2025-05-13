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
##################################################################################
class StringCalculator
  def add(string)
    # If the string is empty, return 0
    return 0 if string.empty?

    # If the string contains negative numbers, raise an exception
    negative_numbers = string.scan(/-\d+/)
    raise "negative numbers not allowed #{negative_numbers.join(', ')}" if negative_numbers.any?

    # if the string contains a custom delimiter, extract it
    if string.start_with?('//')
      delimiter = string[2]
      string = string[4..].tr(delimiter, ',')
    end

    # If the string contains only one number, return that number. Ommit newlines and split by commas
    comma_separated = string.tr("\n", ',').split(',')
    comma_separated.map(&:to_i).sum
  end
end
