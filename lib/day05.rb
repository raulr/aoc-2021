# frozen_string_literal: true

require 'base'

# https://adventofcode.com/2021/day/5
class Day05 < Base
  Point = Struct.new(:x, :y)
  Line = Struct.new(:point_a, :point_b) do
    def horizontal?
      point_a.y == point_b.y
    end

    def vertical?
      point_a.x == point_b.x
    end

    def horizontal_or_vertical?
      horizontal? || vertical?
    end

    def covered_points
      if horizontal?
        horizontal_points
      elsif vertical?
        vertical_points
      else # diagonal 45 degree
        diagonal_points
      end
    end

    private

    def horizontal_points
      x_values.map { |x| Point.new(x, point_a.y) }
    end

    def vertical_points
      y_values.map { |y| Point.new(point_a.x, y) }
    end

    def diagonal_points
      Enumerator.new do |y|
        x_enum = x_values
        y_enum = y_values

        loop do
          y << Point.new(x_enum.next, y_enum.next)
        rescue StopIteration
          break
        end
      end
    end

    def x_values
      (point_a.x..point_b.x).step(point_b.x <=> point_a.x)
    end

    def y_values
      (point_a.y..point_b.y).step(point_b.y <=> point_a.y)
    end
  end

  # Diagram that represents a field of hydrothermal vents
  class Diagram
    def initialize
      @matrix = []
    end

    def <<(line)
      line.covered_points.each do |point|
        @matrix[point.x] ||= []
        @matrix[point.x][point.y] ||= 0
        @matrix[point.x][point.y] += 1
      end
    end

    def overlaps
      @matrix.sum do |column|
        column&.count { |value| value&.>= 2 } || 0
      end
    end
  end

  def solve
    diagram = Diagram.new
    horizontal_and_vertical_lines.each do |line|
      diagram << line
    end
    diagram.overlaps
  end

  def solve2
    diagram = Diagram.new
    parse_lines.each do |line|
      diagram << line
    end
    diagram.overlaps
  end

  private

  def horizontal_and_vertical_lines
    parse_lines.select(&:horizontal_or_vertical?)
  end

  def parse_lines
    iterator.map do |raw|
      /\A(?<x1>\d+),(?<y1>\d+) -> (?<x2>\d+),(?<y2>\d+)\z/.match(raw) do |m|
        p1 = Point.new m[:x1].to_i, m[:y1].to_i
        p2 = Point.new m[:x2].to_i, m[:y2].to_i
        Line.new p1, p2
      end
    end
  end
end
