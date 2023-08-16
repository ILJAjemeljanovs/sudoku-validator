class Validator
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
    @puzzle = PuzzleParser.new(puzzle_string).parse
  end

  def self.validate(puzzle_string)
    begin
      new(puzzle_string).validate
    rescue SudokuFormatError, ValidSudokuMessage, InvalidSudokuError, IncompleteSudokuError => e
      e.message
    end
  end

  def validate
    raise ValidSudokuMessage if @puzzle.valid?
    raise InvalidSudokuError unless @puzzle.correct?
    raise IncompleteSudokuError unless @puzzle.complete?
  end
end
