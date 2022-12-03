# frozen_string_literal: true

Dir['./lib/**/*.rb'].each { |file| require file }

module AdventOfCode
  class Error < StandardError; end
  # Your code goes here...
end
