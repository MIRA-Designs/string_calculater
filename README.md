# StringCalculator

A simple Ruby-based String Calculator built with **Test-Driven Development (TDD)** principles.

This project demonstrates TDD in action by incrementally building a calculator that sums numbers from a formatted input string. Each step was driven by writing tests first using **Minitest**.

---

## Features

- Returns `0` for empty string input
- Handles:
  - Single numbers (`"1"` -> `1`)
  - Two numbers (`"1,2"` -> `3`)
  - An unknown amount of numbers
  - Newlines between numbers (`"1\n2,3"` -> `6`)
  - Custom delimiters (`"//[;]\n1;2"` -> `3`)
  - Negative number detection with error (`"-1"` -> Exception!!)
  - Ignores numbers > 1000 (`"2,1001"` -> `2`)
  - Multiple custom delimiters (`"//[*][%]\n1*2%3"` -> `6`)
  - Delimiters with length > 1 (`"//[***]\n1***2***3"` -> `6`)
  - Combined multi-char delimiters (`"//[**][%%]\n1**2%%3"` -> `6`)

---

## Installation

```bash
git clone https://github.com/MIRA-Designs/string_calculater
cd string_calculator
irb
require_relative 'string_calculator'

calculator = StringCalculator.new
puts calculator.add("1,2,3")

ruby test_string_calculator.rb # run tests

