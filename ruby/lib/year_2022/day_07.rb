# frozen_string_literal: true

module Year2022
  class Day07 < AdventOfCode::PuzzleBase
    def part1
      setup_directory_files
      directory_sizes.filter { |_k, v| v <= 100_000 }.values.sum
    end

    def part2
      setup_directory_files
      total_disk = 70_000_000
      needed_space = 30_000_000 - (total_disk - directory_sizes['root'])
      directory_sizes.filter { |_k, v| v >= needed_space }.values.min
    end

    private

    def setup
      @current_directory = 'root'
      @directories = {}
    end

    def log
      @log ||= @input.split("\n")
    end

    def directory_sizes
      @directory_sizes ||= @directories.transform_values do |files|
        files.values.sum
      end
    end

    def update_current_directory(log_line)
      return unless log_line.start_with?('$ cd ')

      directory = log_line.split('$ cd ')[1]
      case directory
      when '..'
        @current_directory = @current_directory.split('/')[0..-2].join('/')
        @current_directory = 'root' if @current_directory == ''
      when '/'
        @current_directory = 'root'
      else
        @current_directory = "#{@current_directory}/#{directory}".gsub('root', '')
      end

      @current_directory = @current_directory.gsub(%r{^/}, '') unless @current_directory == 'root'
      @directories[@current_directory] ||= {}
    end

    def add_file_contents(log_line)
      first_string = log_line.split[0]
      return unless first_string.to_i.to_s == first_string

      @directories[@current_directory]["#{@current_directory}/#{log_line.split[1]}"] = first_string.to_i
    end

    def setup_directory_files
      setup
      log.each do |log_line|
        if log_line.start_with?('$ cd ')
          update_current_directory(log_line)
        elsif !log_line.start_with?('$')
          add_file_contents(log_line)
        end
      end
      @directories.each_key do |directory|
        if directory.include?('/')
          sub_dirs = directory.split('/')
          sub_dirs.each_with_index do |_sub_dir, i|
            full_sub_dir = sub_dirs[0..i].join('/')
            @directories[full_sub_dir] ||= {}
            @directories[full_sub_dir].merge!(@directories[directory])
            @directories['root'].merge!(@directories[full_sub_dir])
          end
        else
          @directories['root'].merge!(@directories[directory])
        end
      end
    end
  end
end
