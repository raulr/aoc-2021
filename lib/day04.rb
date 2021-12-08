# frozen_string_literal: true

require 'base'

# https://adventofcode.com/2021/day/4
class Day04 < Base
  # Represents a number in a bingo board
  class BoardNumber
    attr_reader :number

    def initialize(number)
      @number = number
      @marked = false
    end

    def check(number)
      @marked = true if number == @number
    end

    def marked?
      @marked
    end
  end

  # A bingo board
  class Board
    ROW_SIZE = 5

    def initialize(numbers)
      @numbers = numbers.map { |n| BoardNumber.new(n) }
    end

    def check(number)
      @numbers.each { |n| n.check(number) }
    end

    def winner?
      any_completed_row? || any_completed_column?
    end

    def unmarked_sum
      @numbers.reject(&:marked?)
              .map(&:number)
              .sum
    end

    private

    def rows
      @numbers.each_slice(ROW_SIZE).to_a
    end

    def columns
      rows.transpose
    end

    def any_completed_row?
      rows.any? do |row|
        row.all?(&:marked?)
      end
    end

    def any_completed_column?
      columns.any? do |column|
        column.all?(&:marked?)
      end
    end
  end

  def solve
    numbers = parse_numbers
    boards = parse_boards

    last_number, winner_board =
      numbers.each do |number|
        winner = boards.each { |b| b.check(number) }
                       .find(&:winner?)

        break [number, winner] if winner
      end

    last_number * winner_board.unmarked_sum
  end

  def solve2
    numbers = parse_numbers
    boards = parse_boards

    last_number, loser_board =
      numbers.each do |number|
        boards.each { |b| b.check(number) }

        break [number, boards.first] if boards.all?(&:winner?)

        boards.delete_if(&:winner?)
      end

    last_number * loser_board.unmarked_sum
  end

  private

  def parse_numbers
    iterator.peek
            .split(',')
            .map(&:to_i)
  end

  def parse_boards
    iterator.to_a
            .drop(1)
            .each_slice(6)
            .with_object([]) do |slice, memo|
      slice.shift # first element is empty
      board_numbers = slice.map do |line|
        line.strip.split(/\s+/).map(&:to_i)
      end

      memo << Board.new(board_numbers.flatten)
    end
  end
end
