# frozen_string_literal: true

require 'day04'

RSpec.describe 'Day 4' do
  let(:path) { 'spec/samples/day04_sample.txt' }
  let(:instance) { Day04.new(path) }

  context 'Part 1' do
    subject { instance.solve }

    it 'should calculate the score of the winning board' do
      expect(subject).to eq 4512
    end
  end

  context 'Part 2' do
    subject { instance.solve2 }

    it 'should calculate the score of the board that will win last' do
      expect(subject).to eq 1924
    end
  end
end
