# frozen_string_literal: true

require 'day01'

RSpec.describe 'Day 1' do
  let(:path) { 'spec/samples/day01_sample.txt' }
  let(:instance) { Day01.new(path) }

  context 'Part 1' do
    subject { instance.solve }

    it 'should count the number of times a depth measurement increases' do
      expect(subject).to eq 7
    end
  end

  context 'Part 2' do
    subject { instance.solve2 }

    it 'should count the number of times the sum of measurements in this sliding window increases' do
      expect(subject).to eq 5
    end
  end
end
