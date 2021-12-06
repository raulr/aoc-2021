# frozen_string_literal: true

require 'base'

# https://adventofcode.com/2021/day/2
class Day02 < Base
  Submarine = Struct.new(:horizontal_position, :depth) do
    def forward(units)
      self.horizontal_position += units
    end

    def down(units)
      self.depth += units
    end

    def up(units)
      self.depth -= units
    end

    def product
      horizontal_position * depth
    end
  end

  SubmarineWithAim = Struct.new(:horizontal_position, :depth, :aim) do
    def forward(units)
      self.horizontal_position += units
      self.depth += aim * units
    end

    def down(units)
      self.aim += units
    end

    def up(units)
      self.aim -= units
    end

    def product
      horizontal_position * depth
    end
  end

  def solve
    pilot Submarine.new(0, 0)
  end

  def solve2
    pilot SubmarineWithAim.new(0, 0, 0)
  end

  private

  def pilot(submarine)
    iterator.each do |line|
      instruction, value = line.split(' ', 2)

      submarine.public_send instruction, value.to_i
    end

    submarine.product
  end
end
