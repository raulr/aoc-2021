# frozen_string_literal: true

require 'day02'

RSpec.describe 'Day 2' do
  let(:path) { 'spec/samples/day02_sample.txt' }
  let(:instance) { Day02.new(path) }

  context 'Part 1' do
    subject { instance.solve }

    it 'should multiply the final horizontal position by the final depth' do
      expect(subject).to eq 150
    end
  end

  context 'Part 2' do
    subject { instance.solve2 }

    it 'should multiply the final horizontal position by the final depth taking aim into account' do
      expect(subject).to eq 900
    end
  end
end
