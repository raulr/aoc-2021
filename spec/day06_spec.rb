# frozen_string_literal: true

require 'day06'

RSpec.describe 'Day 6' do
  let(:path) { 'spec/samples/day06_sample.txt' }
  let(:instance) { Day06.new(path) }

  context 'Part 1' do
    subject { instance.solve }

    it 'should calculate how many lanternfish would there be after 80 days' do
      expect(subject).to eq 5934
    end
  end
end
