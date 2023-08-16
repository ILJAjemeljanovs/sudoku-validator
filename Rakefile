#!/usr/bin/env rake

require 'rspec/core/rake_task'
require "pry"

RSpec::Core::RakeTask.new(:spec)

desc 'Validate a `*.sudoku` file'
task :run do
  # Get the absolute path to the folder containing the files
  lib_path = File.expand_path('lib', __dir__)

  # List all Ruby files in the folder
  Dir.glob(File.join(lib_path, '**', '*.rb')).each do |file|
    require file
  end

  filename = ARGV[1]

  begin
    raise 'Nepieciešams norādīt failu ar .sudoku faila tipu' unless File.extname(filename) == '.sudoku'

    sudoku_string = File.read(filename)
    print Validator.validate(sudoku_string)
    print "\n"
  rescue TypeError => _e
    raise 'Nepieciešams norādīt faila nosaukumu'
  rescue Errno::ENOENT => _e
    raise 'Nepareizs faila nosaukums'
  end
end
