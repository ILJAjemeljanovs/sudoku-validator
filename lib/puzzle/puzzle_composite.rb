module Puzzle
  class PuzzleComposite
    attr_accessor :lines, :columns, :quadrants, :math_check_passed, :overall_corectness, :range_validity_passed
    def initialize
      @lines = []
      @columns = []
      @quadrants = []
      @math_check_passed = false
    end

    # Function purposes:
    # - populate puzzle construct
    # - check mathematical validity of every sudoku element and puzzle itself
    # Returns populated Puzzle object
    def populate!(base_lines_array)
      populate_lines!(base_lines_array)
      populate_columns!(base_lines_array)
      populate_quadrants!(base_lines_array)
      set_math_and_range_validity!(base_lines_array)
    end

    # Function purposes:
    # - checks completeness state of the puzle
    # Returns boolean
    def complete?
      return false if lines.any?(&:incomplete?)
      return false if columns.any?(&:incomplete?)

      true
    end

    # Function purposes:
    # - checks validness state of the puzle
    # Returns boolean
    def valid?
      return false unless math_check_passed
      return false unless correct?

      true
    end

    # Function purposes:
    # - checks correctness state of the puzle
    # Returns boolean
    def correct?
      return overall_corectness unless overall_corectness.nil?

      self.overall_corectness = range_validity_passed &&
                                lines.none?(&:contains_duplicates?) &&
                                columns.none?(&:contains_duplicates?) &&
                                quadrants.none?(&:contains_duplicates?)

      overall_corectness
    end

    private
    # Function purposes:
    # - set range validity attribute
    def set_range_validity!

    end

    # Function purposes:
    # - populate Puzzle with Line objects
    def populate_lines!(base_lines_array)
      base_lines_array.each do |line|
        self.lines << Puzzle::Line.new(line)
      end
    end

    # Function purposes:
    # - populate Puzzle with Column objects
    def populate_columns!(base_lines_array)
      base_lines_array.transpose.each do |column|
        self.columns << Puzzle::Column.new(column)
      end
    end

    # Function purposes:
    # - populate Puzzle with Quadrant objects
    def populate_quadrants!(base_lines_array)
      quadrant_columns = base_lines_array.map { |line| line.each_slice(3).to_a }.transpose

      quadrant_columns.each do |quadrant_column|
        quadrant_column.each_slice(3).to_a.map(&:flatten).each do |quadrant|
          self.quadrants << Puzzle::Quadrant.new(quadrant)
        end
      end
    end

    # Function purposes:
    # - set mathematical validity attribute
    # - set range validity attribute
    def set_math_and_range_validity!(base_lines_array)
      all_digits = base_lines_array.flatten
      self.range_validity_passed = all_digits.all? { |num| (0..9).to_a.include?(num) }

      return if all_digits.sum != 405
      return if lines.any?(&:checksum_failed?)
      return if columns.any?(&:checksum_failed?)
      return if quadrants.any?(&:checksum_failed?)

      self.math_check_passed = true
    end

  end
end
