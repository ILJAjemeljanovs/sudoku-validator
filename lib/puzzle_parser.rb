class PuzzleParser
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
    @puzzle = Puzzle::PuzzleComposite.new
  end

  # Function purposes:
  # - parses the input string
  # - constructs composite puzzle object
  # Returns Puzzle object
  def parse
    @puzzle.populate!(base_lines_array)

    @puzzle
  end

  private

  # Function purposes:
  # - parse input string into array of lines,
  # - reject the lines without numbers
  # - check structural integrity of the parsed data
  # Returns array of arrays if data integrity preserved
  def base_lines_array
    lines_array = @puzzle_string.gsub('-', '')
                                .gsub('+', '')
                                .gsub("\r", '')
                                .split("\n")
                                .reject(&:empty?)
                                .compact
                                .map{ |line| line.scan(/\d+/).map(&:to_i) }
    check_line_structural_integrity!(lines_array)

    lines_array
  end

  # Function purposes:
  # - check structural integrity of each line
  # Raises error message if data integrity is compromised
  def check_line_structural_integrity!(lines_array)
    raise SudokuFormatError if lines_array.size != 9

    lines_array.each do |line|
      next if line.count == 9

      raise SudokuFormatError
    end
  end
end
