# frozen_string_literal: true

require 'fileutils'
require 'httparty'

module AdventOfCode
  class InputLoader
    attr_reader :year, :day, :input_path

    def initialize(year, day, input_path = nil)
      @year = year
      @day = day
      @input_path = input_path || '../inputs'
    end

    def input_data
      download
      File.read(filename)
    end

    private

    def is_test?
      input_path.include?('test_input')
    end

    def download
      # if file exists, don't download
      if File.exist?(filename)
        puts "File already exists: #{filename}" unless is_test?
        return
      end

      # create directory if it doesn't exist

      FileUtils.mkdir_p(File.dirname(filename))

      puts "Downloading input for day #{@day} of #{@year}..." unless is_test?
      return unless fetch&.code == 200

      data = fetch.body

      File.write(filename, data)
    end

    def fetch
      return if is_test?

      @fetch ||= HTTParty.get(url, headers: { 'Cookie' => "session=#{token}" })
    end

    def token
      File.read('../.aoc_token').strip
    end

    def filename
      "#{input_path}/#{year}/#{format('%02d', day)}.txt"
    end

    def url
      "https://adventofcode.com/#{year}/day/#{day}/input"
    end
  end
end
