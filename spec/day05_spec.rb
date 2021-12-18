# frozen_string_literal: true

require 'day05'

RSpec.describe 'Day 5' do
  let(:path) { 'spec/samples/day05_sample.txt' }
  let(:instance) { Day05.new(path) }

  context 'Part 1' do
    subject { instance.solve }

    it 'should determine the number of points where at least two lines overlap' do
      expect(subject).to eq 5
    end
  end

  context 'Part 2' do
    subject { instance.solve2 }

    it 'should determine the number of points where at least two lines overlap considering diagonal lines' do
      expect(subject).to eq 12
    end
  end
end
