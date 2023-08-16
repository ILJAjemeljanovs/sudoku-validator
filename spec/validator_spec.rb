lib_path = File.expand_path('../lib', __dir__)
Dir.glob(File.join(lib_path, '**', '*.rb')).each do |file|
  require file
end

describe 'End-to-end test' do
  # These specs are supposed to fail when you first start this exercise.
  # Your job is to make them pass.

  context 'when the sudoku is valid' do
    context 'and it is complete' do
      it 'returns a string saying so' do
        file = File.read('spec/fixtures/valid_complete.sudoku')

        result = Validator.validate(file)

        expect(result).to eq 'Sudoku is valid.'
      end
    end

    context 'and it is incomplete' do
      it 'returns a string saying so' do
        file = File.read('spec/fixtures/valid_incomplete.sudoku')

        result = Validator.validate(file)

        expect(result).to eq 'Sudoku is valid but incomplete.'
      end
    end
  end

  context 'when the sudoku is invalid' do
    invalid_fixtures = ['spec/fixtures/invalid_due_to_row_dupe.sudoku',
                        'spec/fixtures/invalid_due_to_column_dupe.sudoku',
                        'spec/fixtures/invalid_due_to_subgroup_dupe.sudoku',
                        'spec/fixtures/invalid_due_to_forbidden_characters.sudoku']

    invalid_fixtures.each do |fixture|
      it 'returns a string saying so' do
        result = Validator.validate(File.read(fixture))

        expect(result).to(
          eq('Sudoku is invalid.'),
          "Expected #{fixture} to be invalid but it wasn't."
        )
      end
    end
  end

  context 'when sudoku grid has invalid format' do
    invalid_fixtures = ['spec/fixtures/parse_error_incorrect_line_count.sudoku',
                        'spec/fixtures/parse_error_incorrect_digits_count.sudoku']

    invalid_fixtures.each do |fixture|
      it 'returns a string saying so' do
        result = Validator.validate(File.read(fixture))
        expect(result).to(
          eq('Sudoku format is compromised! Please ensure that every line has exactly 9 digits with a total of 9 lines!'),
          "Expected #{fixture} to be raise format error but it wasn't."
        )
      end
    end
  end
end

describe 'Parser unit tests' do
  context 'when parsing input file' do
    it 'returns composite Puzzle object' do
      file = File.read('spec/fixtures/simple.sudoku')
      puzzle = PuzzleParser.new(file).parse

      expect(puzzle.class).to eq(Puzzle::PuzzleComposite)
    end
  end
end

describe 'PuzzleComposite unit tests' do
  context 'when building composite object' do
    let(:input_data) { [[1,2,3],[4,5,6],[7,8,9]] }
    let(:incomplete_data) { [[0,2,3],[4,5,6],[7,8,9]] }
    let(:incorrect_data) { [[2,2,3],[4,5,6],[7,8,9]] }
    let(:out_of_range_data) { [[10,2,3],[4,5,6],[7,8,9]] }
    let(:puzzle) { Puzzle::PuzzleComposite.new }

    it 'populates itself with lines, columns and quadrants' do
      puzzle.populate!(input_data)
      expect(puzzle.lines.count).to eq(3)
      expect(puzzle.columns.count).to eq(3)
      expect(puzzle.quadrants.count).to eq(1)
    end

    it 'knows if puzzle is complete' do
      puzzle.populate!(input_data)
      expect(puzzle.complete?).to eq(true)

      puzzle = Puzzle::PuzzleComposite.new
      puzzle.populate!(incomplete_data)
      expect(puzzle.complete?).to eq(false)
    end

    it 'knows if puzzle is correct' do
      puzzle.populate!(input_data)
      expect(puzzle.correct?).to eq(true)

      puzzle = Puzzle::PuzzleComposite.new
      puzzle.populate!(incorrect_data)
      expect(puzzle.correct?).to eq(false)

      puzzle = Puzzle::PuzzleComposite.new
      puzzle.populate!(out_of_range_data)
      expect(puzzle.correct?).to eq(false)
    end

    it 'knows if puzzle is valid' do
      puzzle.populate!(input_data)
      puzzle.math_check_passed = true
      expect(puzzle.valid?).to eq(true)

      puzzle = Puzzle::PuzzleComposite.new
      puzzle.populate!(input_data)
      expect(puzzle.valid?).to eq(false)
    end
  end
end

describe 'AbstractSudokuElement unit tests through Lines, Columns and Quadrants' do
  context 'when building sudoku element' do
    it 'knows if it has valid checksum' do
      sudoku_element = Puzzle::Line.new([1, 44])
      expect(sudoku_element.checksum_failed?).to eq(false)

      sudoku_element = Puzzle::Line.new([2, 44])
      expect(sudoku_element.checksum_failed?).to eq(true)
    end

    it 'knows if it is complete' do
      sudoku_element = Puzzle::Column.new([1, 2, 3])
      expect(sudoku_element.incomplete?).to eq(false)

      sudoku_element = Puzzle::Column.new([1, 2, 0])
      expect(sudoku_element.incomplete?).to eq(true)
    end

    it 'knows if it contains duplicates' do
      sudoku_element = Puzzle::Quadrant.new([1, 2, 3])
      expect(sudoku_element.contains_duplicates?).to eq(false)

      sudoku_element = Puzzle::Quadrant.new([1, 2, 1])
      expect(sudoku_element.contains_duplicates?).to eq(true)
    end
  end
end
