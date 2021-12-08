# frozen_string_literal: true

require 'pathname'

# Base class to use in all solutions
class Base
  def initialize(file_path)
    @path = Pathname.new(file_path)
    raise ArgumentError, 'Invalid file' unless @path.file? && @path.readable?

    @iterator = @path.each_line(chomp: true).lazy
  end

  private

  attr_reader :iterator
end
