module Puzzle
  class AbstractSudokuElement
    attr_accessor :values

    def initialize(array)
      @values = array
    end

    # Function purposes:
    # - check element's mathematical validity
    # Returns boolean
    def checksum_failed?
      values.sum != 45
    end

    # Function purposes:
    # - check element's completeness
    # Returns boolean
    def incomplete?
      values.any?(&:zero?)
    end

    # Function purposes:
    # - check element for duplicates
    # Returns boolean
    def contains_duplicates?
      non_zero_values = values.select { |val| val.positive? }.compact
      non_zero_values.size != non_zero_values.uniq.size
    end
  end
end
