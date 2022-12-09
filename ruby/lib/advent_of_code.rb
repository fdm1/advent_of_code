# frozen_string_literal: true

require 'pry-byebug'

Dir['./lib/**/*.rb'].each { |file| require file }
