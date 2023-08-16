class SudokuFormatError < StandardError
  def initialize
    super 'Sudoku format is compromised! Please ensure that every line has exactly 9 digits with a total of 9 lines!'
  end
end

class InvalidSudokuError < StandardError
  def initialize
    super 'Sudoku is invalid.'
  end
end

class IncompleteSudokuError < StandardError
  def initialize
    super 'Sudoku is valid but incomplete.'
  end
end

class ValidSudokuMessage < StandardError
  def initialize
    super 'Sudoku is valid.'
  end
end
