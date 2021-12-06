# frozen_string_literal: true

require 'base'

# https://adventofcode.com/2021/day/1
class Day01 < Base
  def solve
    iterator.map(&:to_i)
            .each_cons(2)
            .select { |a, b| a < b }
            .count
  end

  def solve2
    iterator.map(&:to_i)
            .each_cons(3)
            .map(&:sum)
            .each_cons(2)
            .select { |a, b| a < b }
            .count
  end
end
