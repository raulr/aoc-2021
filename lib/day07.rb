# frozen_string_literal: true

require 'base'

# https://adventofcode.com/2021/day/7
class Day07 < Base
  def initialize(file_path)
    super
    @crab_positions = parse_crab_positions
    @min = @crab_positions.min
    @max = @crab_positions.max
  end

  def solve
    (@min..@max).map { |position| calculate_direct_fuel_for(position) }
                .min
  end

  def solve2
    (@min..@max).map { |position| calculate_exponential_fuel_for(position) }
                .min
  end

  private

  def parse_crab_positions
    iterator.next.split(',').map(&:to_i)
  end

  def calculate_direct_fuel_for(position)
    @crab_positions.map do |crab_position|
      (crab_position - position).abs
    end.sum
  end

  def calculate_exponential_fuel_for(position)
    @crab_positions.map do |crab_position|
      steps = (crab_position - position).abs
      next 0 if steps.zero?

      ((steps + 1) / 2.0 * steps).to_i
    end.sum
  end
end
