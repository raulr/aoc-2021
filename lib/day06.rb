# frozen_string_literal: true

require 'base'
require 'forwardable'

# https://adventofcode.com/2021/day/6
class Day06 < Base
  Lanternfish = Struct.new(:timer) do
    def tick
      self.timer -= 1

      return unless timer.negative?

      self.timer = 6
      Lanternfish.new(8)
    end
  end

  # School of lanterfish
  class School
    extend Forwardable
    def_delegators :@lanternfishes, :<<, :count

    def initialize
      @lanternfishes = []
    end

    def tick
      @lanternfishes += @lanternfishes.map(&:tick).compact
    end
  end

  def solve
    calculate_amount_after 80
  end

  private

  def parse_lanterfishes
    school = School.new
    iterator.next.split(',').map { |timer| school << Lanternfish.new(timer.to_i) }
    school
  end

  def calculate_amount_after(days)
    school = parse_lanterfishes
    days.times { school.tick }
    school.count
  end
end
