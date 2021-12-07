# frozen_string_literal: true

require 'day03'

RSpec.describe 'Day 3' do
  let(:path) { 'spec/samples/day03_sample.txt' }
  let(:instance) { Day03.new(path) }

  context 'Part 1' do
    subject { instance.solve }

    it 'should calculate the power consumption of the submarine' do
      expect(subject).to eq 198
    end
  end

  context 'Part 2' do
    subject { instance.solve2 }

    it 'should calculate the life support rating of the submarine' do
      expect(subject).to eq 230
    end
  end
end
