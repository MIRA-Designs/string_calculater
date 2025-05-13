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
##################################################################################
class StringCalculator
  def add(string)
    # If the string is empty, return 0
    return 0 if string.empty?

    # if the string contains a custom delimiter, extract it
    if string.start_with?('//')
      # Extract the custom delimiter
      delimiter = string[2]
      string = string.gsub("//#{delimiter}\n", '').gsub(delimiter, ',')
    end

    # If the string contains only one number, return that number. Ommit newlines and split by commas
    comma_separated = string.gsub("\n", ',').split(',')
    comma_separated.map(&:to_i).reduce(:+)
  end
end
