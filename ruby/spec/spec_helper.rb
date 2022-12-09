# frozen_string_literal: true

require 'advent_of_code'

Dir['../lib/**/*.rb'].each { |file| require file }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def puzzle_test_runner(year, day, suffix = nil)
  AdventOfCode::Runner.new(year, day, '../test_input', suffix)
end
