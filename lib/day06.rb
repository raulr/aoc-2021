# frozen_string_literal: true

require 'base'
require 'forwardable'

# https://adventofcode.com/2021/day/6
class Day06 < Base
  Lanternfish = Struct.new(:timer, :number) do
    def tick
      self.timer -= 1

      return unless timer.negative?

      self.timer = 6
      Lanternfish.new(8, number)
    end

    def eql?(other)
      timer == other.timer
    end

    def +(other)
      Lanternfish.new(timer, number + other.number)
    end
  end

  # School of lanterfish
  class School
    extend Forwardable
    def_delegator :@lanternfishes, :<<

    def initialize
      @lanternfishes = []
    end

    def tick
      @lanternfishes = @lanternfishes.each_with_object([]) do |lanterfish, response|
        if (spawned_lanterfish = lanterfish.tick)
          response << spawned_lanterfish
        end

        if (index = response.index(lanterfish))
          response[index] = response[index] + lanterfish
        else
          response << lanterfish
        end
      end
    end

    def count
      @lanternfishes.sum(&:number)
    end
  end

  def solve
    calculate_amount_after 80
  end

  def solve2
    calculate_amount_after 256
  end

  private

  def parse_lanterfishes
    school = School.new
    iterator.next.split(',').map(&:to_i).tally.map { |timer, number| school << Lanternfish.new(timer, number) }
    school
  end

  def calculate_amount_after(days)
    school = parse_lanterfishes
    days.times { school.tick }
    school.count
  end
end
