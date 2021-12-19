# frozen_string_literal: true

require 'day07'

RSpec.describe 'Day 7' do
  let(:path) { 'spec/samples/day07_sample.txt' }
  let(:instance) { Day07.new(path) }

  context 'Part 1' do
    subject { instance.solve }

    it 'should calculate how much fuel must crabs spend to align using the least fuel possible' do
      expect(subject).to eq 37
    end
  end

  context 'Part 2' do
    subject { instance.solve2 }

    it 'should calculate how much fuel must crabs spend to align using the least fuel possible with exponential cost' do
      expect(subject).to eq 168
    end
  end
end
