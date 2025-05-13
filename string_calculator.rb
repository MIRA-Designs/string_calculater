# frozen_string_literal: true

##################################################################################
# StringCalculator class that has only one method `add`
#   The `add` method takes a string that contains numbers separated by commas, delimiters, or newlines
#   and returns the sum of numbers by ommitting the delimiters, commas, and newlines
#   1. The `add` method should return 0 for an empty string
#      The `add` method should return the number itself for a single number
##################################################################################
class StringCalculator
  def add(string)
    # If the string is empty, return 0
    return 0 if string.empty?

    # If the string contains only one number, return that number
    comma_separated = string.split(',')
    if comma_separated.size > 1
      comma_separated.map(&:to_i).reduce(:+)
    else
      string.to_i
    end
  end
end
