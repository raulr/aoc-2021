# frozen_string_literal: true

require 'base'

# https://adventofcode.com/2021/day/3
class Day03 < Base
  # Calculates the most and least common bit for each index
  class BitFrequency
    def initialize
      @counter = []
    end

    def increment(index, bit)
      @counter[index] ||= { '1' => 0, '0' => 0 }
      @counter[index][bit] += 1
    end

    def most_common(index)
      @counter[index].max_by { |_k, v| v }
                     .first
    end

    def least_common(index)
      # reverse first so in case of a tie, '0' is returned
      @counter[index].reverse_each
                     .to_h
                     .min_by { |_k, v| v }
                     .first
    end

    def bits
      @counter.length
    end
  end

  def solve
    frequency = calculate_frequency iterator
    gamma_rate = frequency.bits
                          .times
                          .map { |index| frequency.most_common(index) }
                          .join
                          .to_i(2)
    epsilon_rate = (~gamma_rate) & ('1' * frequency.bits).to_i(2)

    gamma_rate * epsilon_rate
  end

  def solve2
    oxygen_generator = filter_with_criteria(:most_common).to_i(2)
    co2_scrubber = filter_with_criteria(:least_common).to_i(2)

    oxygen_generator * co2_scrubber
  end

  private

  def calculate_frequency(iterable)
    iterable.each_with_object(BitFrequency.new) do |value, frequency|
      value.each_char.with_index do |bit, index|
        frequency.increment index, bit
      end
    end
  end

  def filter_with_criteria(criteria)
    raise ArgumentError unless %i[most_common least_common].include?(criteria)

    bits = iterator.peek.length

    bits.times.each_with_object(iterator.to_a) do |index, list|
      frequency = calculate_frequency list
      list.select! { |value| value[index] == frequency.public_send(criteria, index) }

      break list if list.size == 1
    end.first
  end
end
