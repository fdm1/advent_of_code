# frozen_string_literal: true

require_relative 'advent_of_code/version'
Dir['./lib/**/*.rb'].each { |file| require file }

module AdventOfCode
  class Error < StandardError; end
  # Your code goes here...
end
